// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Split} from "../src/Split.sol";
import {SPNFT} from "../src/SPNFT.sol";

// ERC-20 interface for interacting with the USDC token
interface IERC20 {
    function balanceOf(address) external view returns (uint256);
    function transfer(address, uint256) external returns (bool);
    function decimals() external view returns (uint8);
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external view returns (bytes32);
    function nonces(address) external view returns (uint256);
}

// SendUSDC_Test is a contract that sets up and runs the test
contract SendUSDC_Test is Test {
    IERC20 usdc; // Interface instance for USDC
    address UNLUCKY_USER = 0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf; // UNLUCKY_USER account address
    address recipient = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; // ACCOUNT_0 address
    uint256 recipient_PrivateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    
    address usdcAddress = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48; // USDC contract address on Ethereum Mainnet

    address splitOwner = 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720; // ACCOUNT_9 address
    uint256 splitOwner_PrivateKey = 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6;

    address nftOwner = address(0x123);
    SPNFT spnft;
    address avatarWallet = 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc; // ACCOUNT_5 address

    address UBIpool = 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f; // ACCOUNT_8 address
    address GPUCostAddr = 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955; // ACCOUNT_7 address
    address teamWallet = 0x976EA74026E726554dB657fA54763abd0C3a0aa9; // ACCOUNT_6 address

    uint64 GPUShare = 5000;
    uint64 UBIShare = 2000;
    uint64 teamShare = 1900;

    Split split;
    // setUp function runs before each test, setting up the environment
    function setUp() public {
        usdc = IERC20(usdcAddress); // Initialize the USDC contract interface
        console.log("block number: ", block.number); // Log the current block number to the console
        console.log("timestamp: ", block.timestamp); // Log the current timestamp to the console

        spnft = new SPNFT();

        vm.prank(splitOwner);
        split = new Split(
            UBIpool,
            address(spnft),
            usdcAddress,
            GPUCostAddr,
            teamWallet,
            GPUShare,
            UBIShare,
            teamShare
        );
    }

    // testTokenTransfer function tests the transfer of USDC from the UNLUCKY_USER account to the recipient
    function tokenTransfer() internal {
        uint256 initialBalance = usdc.balanceOf(recipient); // Get the initial balance of the recipient
        console.log("Recipient's initial balance: ", initialBalance); // Log the initial balance to the console

        uint256 initialBalanceUnlucky = usdc.balanceOf(UNLUCKY_USER); // Get the initial balance of the UNLUCKY_USER
        console.log("UNLUCKY_USER's initial balance: ", initialBalanceUnlucky); // Log the initial balance to the console

        uint8 decimals = usdc.decimals(); // Get the decimal number of USDC
        uint256 transferAmount = 300 * 10 ** decimals; // Set the amount of USDC to transfer (300 tokens, with 6 decimal places)

        // Impersonate the UNLUCKY_USER account for testing
        vm.startPrank(UNLUCKY_USER);
        // Perform the token transfer from the UNLUCKY_USER to the recipient
        usdc.transfer(recipient, transferAmount);

        uint256 finalBalance = usdc.balanceOf(recipient); // Get the final balance of the recipient
        console.log("Recipient's final balance: ", finalBalance); // Log the final balance to the console

        uint256 finalBalanceUnlucky = usdc.balanceOf(UNLUCKY_USER); // Get the final balance of the UNLUCKY_USER
        console.log("UNLUCKY_USER's final balance: ", finalBalanceUnlucky); // Log the final balance to the console

        // Verify that the recipient's balance increased by the transfer amount
        assertEq(finalBalance, initialBalance + transferAmount, "Token transfer failed");

        vm.stopPrank(); // Stop impersonating the UNLUCKY_USER account

        // vm.startPrank(recipient);
        // usdc.transfer(address(0x123), 100 * 10 ** decimals);
        // console.log("0x123 balance:", usdc.balanceOf(address(0x123)));
        // console.log("recipient balance:", usdc.balanceOf(recipient));
        // vm.stopPrank();
    }

    function mintNFT() internal returns (uint256) {
        vm.prank(nftOwner);
        uint256 tokenId = spnft.mint(nftOwner);
        console.log("NFT owner: ", nftOwner);
        console.log("NFT balance: ", spnft.balanceOf(nftOwner));
        console.log("NFT tokenId: ", tokenId);
        return tokenId;
    }

    function mint_and_addShareInfo() internal returns (uint256) {
        uint256 tokenId = mintNFT();
        vm.prank(splitOwner);
        split.addShareInfo(
            tokenId, 
            nftOwner, 
            nftOwner, 
            nftOwner, 
            avatarWallet, 
            3000, 
            2000, 
            1000,
            100);

        return tokenId;
    }

    function sign(
        uint256 _deadline, 
        uint256 _payment
    ) internal view returns (bytes memory) {
        address buyer = vm.addr(recipient_PrivateKey);
        console.log("buyer: ", buyer);

        bytes32 structHash = keccak256(
            abi.encode(
                usdc.PERMIT_TYPEHASH(),
                buyer,
                address(split),
                _payment,
                usdc.nonces(buyer),
                _deadline
            )
        );

        bytes32 digest = keccak256(
            abi.encodePacked(
                "\x19\x01",
                usdc.DOMAIN_SEPARATOR(),
                structHash
            )
        );

        // Generate Signature
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(recipient_PrivateKey, digest);
        bytes memory signatureForList = abi.encodePacked(r, s, v);

        console.log("signatureForList: ");
        console.logBytes(signatureForList);

        return signatureForList;
    }

    function test_buyServiceWithSignature() public {
        uint256 tokenId = mint_and_addShareInfo();
        tokenTransfer();

        // sign
        uint256 _deadline = block.timestamp + 600;
        uint256 _payment = 100000000; 
        bytes memory signatureForList = sign(_deadline, _payment);

        // buy
        vm.prank(recipient);
        split.buyServiceWithSignature(
            tokenId,
            _payment,
            _deadline,
            signatureForList
        );

        // distribute
        split.distribute(tokenId, _payment);

        // check balance
        console.log("UBIpool balance: ", usdc.balanceOf(UBIpool));
        console.log("GPUCostAddr balance: ", usdc.balanceOf(GPUCostAddr));
        console.log("teamWallet balance: ", usdc.balanceOf(teamWallet));
        console.log("avatarWallet balance: ", usdc.balanceOf(avatarWallet));
        console.log("nftOwner balance: ", usdc.balanceOf(nftOwner));
        console.log("recipient balance: ", usdc.balanceOf(recipient));
    }
}