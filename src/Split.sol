//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @dev Profit distribution contract for digital avatar services.
 * The money flows as:
 * Payer --buyService()--> _avatarProfit --distribute()--> profit sharing addresses
 *
 * Shares are augmented by 10000 times. 
 * For example, 20% will be stored as uint64(20 * 100)
 */

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

contract Split is Ownable, Pausable {
    event UBIpoolUpdate(address newAddr);
    event NFTAddrUpdate(address newAddr);
    event GPUAddrUpdate(address newAddr);
    event ShareAddressUpdate(
        uint256 avatarId,
        address copyrightOwner,
        address creator,
        address NFTOwner,
        address avatarWallet
    );
    event SharesUpdate(
        uint256 avatarId,
        uint64 copyrightOwnerShare,
        uint64 creatorShare,
        uint64 NFTOwnerShare,
        uint64 avatarWalletShare
    );
    event PaymentReceived(address payer, uint256 amount);
    event ProfitDistributed(uint256 avatarId, address payee, uint256 amount);

    address public nftAddr; // the address of avatar NFT contract
    address public UBIpool; // a fixed profit sharing address
    address public usdcAddr; // the address of erc20 token contract as currency
    address public GPUCostAddr; // profit consumed to cover GPU cost
    address public teamWallet;
    uint64 public GPUShare; // GPUShare of avatar profit covers the GPU cost
    uint64 public UBIShare; // UBIShare of profit other than GPU cost goes to UBIpool
    uint64 public teamShare; // teamShare of profit other than GPU cost goes to team
    mapping(address => uint256) _totalIncomeOf;
    mapping(uint256 => ShareAddrs) _shareInfoOf; // avatarId => 4 addrs
    mapping(uint256 => Shares) _sharesOf; // avatarId => 4 shares
    mapping(uint256 => uint256) _avatarProfit;

    /**
     * @dev The addresses that the profit will be distributed to.
     */
    struct ShareAddrs {
        address copyrightOwner;
        address creator;
        address NFTOwner;
        address avatarWallet;
    }

    /**
     * @dev Profit shares that each address in the above struct has.
     */
    struct Shares {
        uint64 copyrightOwnerShare;
        uint64 creatorShare;
        uint64 NFTOwnerShare;
        uint64 avatarWalletShare;
    }

    constructor(
        address UBIpool_,
        address nftAddr_,
        address usdcAddr_,
        address GPUCostAddr_,
        address teamWallet_,
        uint64 GPUShare_,
        uint64 UBIShare_,
        uint64 teamShare_
    ) Ownable(msg.sender) {
        UBIpool = UBIpool_;
        nftAddr = nftAddr_;
        usdcAddr = usdcAddr_;
        GPUCostAddr = GPUCostAddr_;
        teamWallet = teamWallet_;
        GPUShare = GPUShare_;
        UBIShare = UBIShare_;
        teamShare = teamShare_;

        require(
            GPUShare_ < 10_000 && UBIShare_ + teamShare_ < 10_000,
            "invalid profit splitting ratio"
        );
    }

    /**
     * @dev Modify the UBIpool address, owner right restricted.
     */
    function setUBIpool(
        address newUBIpoolAddr_
    ) external onlyOwner() whenPaused() {
        UBIpool = newUBIpoolAddr_;

        emit UBIpoolUpdate(newUBIpoolAddr_);
    }

    /**
     * @dev Modify the avatar NFT contract address, owner right restricted.
     */
    function setNFTAddr(
        address newNFTAddr_
    ) external onlyOwner() whenPaused() {
        nftAddr = newNFTAddr_;

        emit NFTAddrUpdate(newNFTAddr_);
    }

    /**
     * @dev Modify the address to receive the GPU cost fees, owner right restricted.
     */
    function setGPUAddr(
        address newGPUAddr_
    ) external onlyOwner() whenPaused() {
        GPUCostAddr = newGPUAddr_;

        emit GPUAddrUpdate(newGPUAddr_);
    }

    function setTeamWallet(
        address newTeamWalletAddr_
    ) external onlyOwner() whenPaused() {
        teamWallet = newTeamWalletAddr_;
    }

    function shareInfoOf(
        uint256 avatarId
    ) public view returns(ShareAddrs memory info) {
        info = _shareInfoOf[avatarId];
    }

    function sharesOf(
        uint256 avatarId
    ) public view returns(Shares memory shares) {
        shares = _sharesOf[avatarId];
    }

    function addShareInfo(
        uint256 avatarId,
        address copyrightOwner_,
        address creator_,
        address NFTOwner_,
        address avatarWallet_,
        uint64 copyrightOwnerShare_,
        uint64 creatorShare_,
        uint64 NFTOwnerShare_,
        uint64 avatarWalletShare_
    ) external onlyOwner() {
        ShareAddrs memory addrs_ = ShareAddrs({
            copyrightOwner: copyrightOwner_,
            creator: creator_,
            NFTOwner: NFTOwner_,
            avatarWallet: avatarWallet_
        });
        _shareInfoOf[avatarId] = addrs_;

        Shares memory shares_ = Shares({
            copyrightOwnerShare: copyrightOwnerShare_,
            creatorShare: creatorShare_,
            NFTOwnerShare: NFTOwnerShare_,
            avatarWalletShare: avatarWalletShare_
        });
        _sharesOf[avatarId] = shares_;

        emit ShareAddressUpdate(avatarId, copyrightOwner_, creator_, NFTOwner_, avatarWallet_);
        emit SharesUpdate(avatarId, copyrightOwnerShare_, creatorShare_, NFTOwnerShare_, avatarWalletShare_);
    }

    function updateShareAddrs(
        uint256 avatarId,
        address newCopyrightOwner_,
        address newCreator_,
        address newNFTOwner_,
        address newAvatarWallet_
    ) external onlyOwner() {
        ShareAddrs memory newAddrs_ = ShareAddrs({
            copyrightOwner: newCopyrightOwner_,
            creator: newCreator_,
            NFTOwner: newNFTOwner_,
            avatarWallet: newAvatarWallet_
        });
        _shareInfoOf[avatarId] = newAddrs_;

        emit ShareAddressUpdate(avatarId, newCopyrightOwner_, newCreator_, newNFTOwner_, newAvatarWallet_);
    }

    function updateShares(
        uint256 avatarId,
        uint64 newCopyrightOwnerShare_,
        uint64 newCreatorShare_,
        uint64 newNFTOwnerShare_,
        uint64 newAvatarWalletShare_
    ) external onlyOwner() {
        Shares memory shares_ = Shares({
            copyrightOwnerShare: newCopyrightOwnerShare_,
            creatorShare: newCreatorShare_,
            NFTOwnerShare: newNFTOwnerShare_,
            avatarWalletShare: newAvatarWalletShare_
        });
        _sharesOf[avatarId] = shares_;

        emit SharesUpdate(avatarId, newCopyrightOwnerShare_, newCreatorShare_, newNFTOwnerShare_, newAvatarWalletShare_);
    }

    /**
     * @dev This function is called by customers to pay USDC to this contract.
     * The adequate USDC should be approved to this contract first, otherwise
     * the call will revert.
     */
    function buyService(
        uint256 avatarId,
        uint256 payment
    ) public whenNotPaused() {
        require(
            IERC20(usdcAddr).transferFrom(msg.sender, address(this), payment),
            "Transfer usdc to this contract failed."
        );

        emit PaymentReceived(msg.sender, payment);

        _avatarProfit[avatarId] += payment;
    }

    /**
     * @dev The signature will have the USDC approved to this contract, once verified.
     */
    function buyServiceWithSignature(
        uint256 avatarId,
        uint256 payment,
        uint256 deadline,
        bytes memory signature
    ) external whenNotPaused() {
        require(signature.length == 65, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        IERC20Permit(usdcAddr).permit(
            msg.sender,
            address(this),
            payment,
            deadline,
            v,
            r,
            s
        );

        buyService(avatarId, payment);
    }

    /**
     * @dev Distribute balance to share accounts once payment is received.
     */
    function distribute(
        uint256 avatarId,
        uint256 amount
    ) external whenNotPaused() {
        require(
            _avatarProfit[avatarId] >= amount, 
            "no enough avatar profit for distribution"
        );
        _avatarProfit[avatarId] -= amount;

        // Split to GPU share
        uint256 GPUPayment = amount * GPUShare / 10_000;
        require(
            IERC20(usdcAddr).transfer(GPUCostAddr, GPUPayment),
            "GPU cost distribution failed"
        );
        _totalIncomeOf[GPUCostAddr] += GPUPayment;

        // Split to UBI pool
        uint256 UBIPayment = amount * (10_000 - GPUShare) * UBIShare / (10_000 * 10_000);
        require(
            IERC20(usdcAddr).transfer(UBIpool, UBIPayment),
            "UBI pool payment failed"
        );
        _totalIncomeOf[UBIpool] += UBIPayment;

        // Split to profit sharing accounts of the avatar
        ShareAddrs memory addrs = _shareInfoOf[avatarId];
        uint256[4] memory shareAmounts = _calShares(
            avatarId,
            (amount - GPUPayment) * (10000 - UBIShare - teamShare) / 10000
        );

        require(
            IERC20(usdcAddr).transfer(addrs.copyrightOwner, shareAmounts[0]) &&
            IERC20(usdcAddr).transfer(addrs.creator, shareAmounts[1]) &&
            IERC20(usdcAddr).transfer(addrs.NFTOwner, shareAmounts[2]) &&
            IERC20(usdcAddr).transfer(addrs.avatarWallet, shareAmounts[3]),
            "avatar profit distribution failed"
        );

        // Do some statistics and inform the net
        _totalIncomeOf[addrs.copyrightOwner] += shareAmounts[0];
        _totalIncomeOf[addrs.creator] += shareAmounts[1];
        _totalIncomeOf[addrs.NFTOwner] += shareAmounts[2];
        _totalIncomeOf[addrs.avatarWallet] += shareAmounts[3];

        emit ProfitDistributed(avatarId, addrs.copyrightOwner, shareAmounts[0]);
        emit ProfitDistributed(avatarId, addrs.creator, shareAmounts[1]);
        emit ProfitDistributed(avatarId, addrs.NFTOwner, shareAmounts[2]);
        emit ProfitDistributed(avatarId, addrs.avatarWallet, shareAmounts[3]);

        // Split to team wallet
        uint256 teamProfit = amount - GPUPayment - UBIPayment 
                            - shareAmounts[0] - shareAmounts[1]
                            - shareAmounts[2] - shareAmounts[3];
        require(
            IERC20(usdcAddr).transfer(teamWallet, teamProfit),
            "team profit distribution failed"
        );
        _totalIncomeOf[teamWallet] += teamProfit;
    }

    function _calShares(
        uint256 avatarId,
        uint256 amount
    ) internal view returns(uint256[4] memory shareAmounts){
        Shares memory shares = _sharesOf[avatarId];

        uint64 totalShare = shares.copyrightOwnerShare + shares.creatorShare +
                            shares.NFTOwnerShare + shares.avatarWalletShare;
        
        shareAmounts[0] = amount * shares.copyrightOwnerShare / totalShare;
        shareAmounts[1] = amount * shares.creatorShare / totalShare;
        shareAmounts[2] = amount * shares.NFTOwnerShare / totalShare;
        shareAmounts[3] = amount * shares.avatarWalletShare / totalShare;
    }

    /**
     * @dev add pausable feature to the contract, owner right restricted
     */
    function pause() public onlyOwner() {
        _pause();
    }

    function unPause() public onlyOwner() {
        _unpause();
    }
}