➜  split git:(main) ✗ forge test --rpc-url http://127.0.0.1:8545/ --match-path test/SendUSDC_Test.sol -vvvv
[⠊] Compiling...
[⠒] Compiling 1 files with Solc 0.8.26
[⠢] Solc 0.8.26 finished in 3.12s
Compiler run successful!

Ran 1 test for test/SendUSDC_Test.sol:SendUSDC_Test
[PASS] test_buyServiceWithSignature() (gas: 576888)
Logs:
  block number:  20559828
  timestamp:  1724036171
  NFT owner:  0x0000000000000000000000000000000000000123
  NFT balance:  1
  NFT tokenId:  0
  Recipient's initial balance:  0
  UNLUCKY_USER's initial balance:  370364750219891
  Recipient's final balance:  300000000
  UNLUCKY_USER's final balance:  370364450219891
  buyer:  0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  signatureForList: 
  0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a51c
  UBIpool balance:  10000000
  GPUCostAddr balance:  50000000
  teamWallet balance:  9500000
  avatarWallet balance:  500000
  nftOwner balance:  30000000
  recipient balance:  200000000

Traces:
  [576888] SendUSDC_Test::test_buyServiceWithSignature()
    ├─ [0] VM::prank(0x0000000000000000000000000000000000000123)
    │   └─ ← [Return] 
    ├─ [69394] SPNFT::mint(0x0000000000000000000000000000000000000123)
    │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0x0000000000000000000000000000000000000123, tokenId: 0)
    │   └─ ← [Return] 0
    ├─ [0] console::log("NFT owner: ", 0x0000000000000000000000000000000000000123) [staticcall]
    │   └─ ← [Stop] 
    ├─ [634] SPNFT::balanceOf(0x0000000000000000000000000000000000000123) [staticcall]
    │   └─ ← [Return] 1
    ├─ [0] console::log("NFT balance: ", 1) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log("NFT tokenId: ", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720)
    │   └─ ← [Return] 
    ├─ [120253] Split::addShareInfo(0, 0x0000000000000000000000000000000000000123, 0x0000000000000000000000000000000000000123, 0x0000000000000000000000000000000000000123, 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, 3000, 2000, 1000, 100)
    │   ├─ emit ShareAddressUpdate(avatarId: 0, copyrightOwner: 0x0000000000000000000000000000000000000123, creator: 0x0000000000000000000000000000000000000123, NFTOwner: 0x0000000000000000000000000000000000000123, avatarWallet: 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc)
    │   ├─ emit SharesUpdate(avatarId: 0, copyrightOwnerShare: 3000, creatorShare: 2000, NFTOwnerShare: 1000, avatarWalletShare: 100)
    │   └─ ← [Stop] 
    ├─ [9839] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   ├─ [2553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [delegatecall]
    │   │   └─ ← [Return] 0
    │   └─ ← [Return] 0
    ├─ [0] console::log("Recipient's initial balance: ", 0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [3339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf) [staticcall]
    │   ├─ [2553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf) [delegatecall]
    │   │   └─ ← [Return] 370364750219891 [3.703e14]
    │   └─ ← [Return] 370364750219891 [3.703e14]
    ├─ [0] console::log("UNLUCKY_USER's initial balance: ", 370364750219891 [3.703e14]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [3164] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::decimals() [staticcall]
    │   ├─ [2381] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::decimals() [delegatecall]
    │   │   └─ ← [Return] 6
    │   └─ ← [Return] 6
    ├─ [0] VM::startPrank(0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf)
    │   └─ ← [Return] 
    ├─ [30152] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 300000000 [3e8])
    │   ├─ [29363] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 300000000 [3e8]) [delegatecall]
    │   │   ├─ emit Transfer(from: 0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf, to: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, value: 300000000 [3e8])
    │   │   └─ ← [Return] true
    │   └─ ← [Return] true
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [delegatecall]
    │   │   └─ ← [Return] 300000000 [3e8]
    │   └─ ← [Return] 300000000 [3e8]
    ├─ [0] console::log("Recipient's final balance: ", 300000000 [3e8]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf) [delegatecall]
    │   │   └─ ← [Return] 370364450219891 [3.703e14]
    │   └─ ← [Return] 370364450219891 [3.703e14]
    ├─ [0] console::log("UNLUCKY_USER's final balance: ", 370364450219891 [3.703e14]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::assertEq(300000000 [3e8], 300000000 [3e8], "Token transfer failed") [staticcall]
    │   └─ ← [Return] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    ├─ [0] console::log("buyer: ", 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1094] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::PERMIT_TYPEHASH() [staticcall]
    │   ├─ [311] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::PERMIT_TYPEHASH() [delegatecall]
    │   │   └─ ← [Return] 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9
    │   └─ ← [Return] 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9
    ├─ [3315] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::nonces(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   ├─ [2529] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::nonces(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [delegatecall]
    │   │   └─ ← [Return] 1
    │   └─ ← [Return] 1
    ├─ [4096] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::DOMAIN_SEPARATOR() [staticcall]
    │   ├─ [3313] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::DOMAIN_SEPARATOR() [delegatecall]
    │   │   └─ ← [Return] 0x06c37168a7db5138defc7866392bb87a741f9b3d104deb5094588ce041cae335
    │   └─ ← [Return] 0x06c37168a7db5138defc7866392bb87a741f9b3d104deb5094588ce041cae335
    ├─ [0] VM::sign("<pk>", 0x830e1c1d1c8117ed572a0ca7a4235118bbeb7de8e6f4138a84a3881486e0531f) [staticcall]
    │   └─ ← [Return] 28, 0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca, 0x18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a5
    ├─ [0] console::log("signatureForList: ") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log(0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a51c) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::prank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266)
    │   └─ ← [Return] 
    ├─ [96693] Split::buyServiceWithSignature(0, 100000000 [1e8], 1724036771 [1.724e9], 0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a51c)
    │   ├─ [40632] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::permit(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], 100000000 [1e8], 1724036771 [1.724e9], 28, 0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca, 0x18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a5)
    │   │   ├─ [39816] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::permit(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], 100000000 [1e8], 1724036771 [1.724e9], 28, 0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca, 0x18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a5) [delegatecall]
    │   │   │   ├─ [6897] 0x800C32EaA2a6c93cF4CB51794450ED77fBfbB172::isValidSignatureNow(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0x830e1c1d1c8117ed572a0ca7a4235118bbeb7de8e6f4138a84a3881486e0531f, 0xb2c3bede1d204031abe5e3367af3fe38b34ee4b6eefd749221a60154fa4accca18c4cb2cc605537b416781de372c96b9c9ab6bde731d7d0804d4a05b5325e9a51c) [delegatecall]
    │   │   │   │   ├─ [3000] PRECOMPILES::ecrecover(0x830e1c1d1c8117ed572a0ca7a4235118bbeb7de8e6f4138a84a3881486e0531f, 28, 80857539545434576039956562870735106703812977314719458161502018450542096469194, 11203212652295033269250977189937148713541571210007462218691777275167406156197) [staticcall]
    │   │   │   │   │   └─ ← [Return] 0x000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266
    │   │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   │   │   ├─ emit Approval(owner: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, spender: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], value: 100000000 [1e8])
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Return] 
    │   ├─ [28449] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transferFrom(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], 100000000 [1e8])
    │   │   ├─ [27654] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transferFrom(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], 100000000 [1e8]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, to: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], value: 100000000 [1e8])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ emit PaymentReceived(payer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, amount: 100000000 [1e8])
    │   └─ ← [Stop] 
    ├─ [217370] Split::distribute(0, 100000000 [1e8])
    │   ├─ [27352] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 50000000 [5e7])
    │   │   ├─ [26563] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, 50000000 [5e7]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x14dC79964da2C08b23698B3D3cc7Ca32193d9955, value: 50000000 [5e7])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ [27352] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 10000000 [1e7])
    │   │   ├─ [26563] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, 10000000 [1e7]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, value: 10000000 [1e7])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ [27352] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x0000000000000000000000000000000000000123, 15000000 [1.5e7])
    │   │   ├─ [26563] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x0000000000000000000000000000000000000123, 15000000 [1.5e7]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x0000000000000000000000000000000000000123, value: 15000000 [1.5e7])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ [5452] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x0000000000000000000000000000000000000123, 10000000 [1e7])
    │   │   ├─ [4663] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x0000000000000000000000000000000000000123, 10000000 [1e7]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x0000000000000000000000000000000000000123, value: 10000000 [1e7])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ [5452] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x0000000000000000000000000000000000000123, 5000000 [5e6])
    │   │   ├─ [4663] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x0000000000000000000000000000000000000123, 5000000 [5e6]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x0000000000000000000000000000000000000123, value: 5000000 [5e6])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ [27352] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, 500000 [5e5])
    │   │   ├─ [26563] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, 500000 [5e5]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, value: 500000 [5e5])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   ├─ emit ProfitDistributed(avatarId: 0, payee: 0x0000000000000000000000000000000000000123, amount: 15000000 [1.5e7])
    │   ├─ emit ProfitDistributed(avatarId: 0, payee: 0x0000000000000000000000000000000000000123, amount: 10000000 [1e7])
    │   ├─ emit ProfitDistributed(avatarId: 0, payee: 0x0000000000000000000000000000000000000123, amount: 5000000 [5e6])
    │   ├─ emit ProfitDistributed(avatarId: 0, payee: 0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc, amount: 500000 [5e5])
    │   ├─ [27352] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::transfer(0x976EA74026E726554dB657fA54763abd0C3a0aa9, 9500000 [9.5e6])
    │   │   ├─ [26563] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::transfer(0x976EA74026E726554dB657fA54763abd0C3a0aa9, 9500000 [9.5e6]) [delegatecall]
    │   │   │   ├─ emit Transfer(from: Split: [0x12975173B87F7595EE45dFFb2Ab812ECE596Bf84], to: 0x976EA74026E726554dB657fA54763abd0C3a0aa9, value: 9500000 [9.5e6])
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Return] true
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f) [delegatecall]
    │   │   └─ ← [Return] 10000000 [1e7]
    │   └─ ← [Return] 10000000 [1e7]
    ├─ [0] console::log("UBIpool balance: ", 10000000 [1e7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x14dC79964da2C08b23698B3D3cc7Ca32193d9955) [delegatecall]
    │   │   └─ ← [Return] 50000000 [5e7]
    │   └─ ← [Return] 50000000 [5e7]
    ├─ [0] console::log("GPUCostAddr balance: ", 50000000 [5e7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x976EA74026E726554dB657fA54763abd0C3a0aa9) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x976EA74026E726554dB657fA54763abd0C3a0aa9) [delegatecall]
    │   │   └─ ← [Return] 9500000 [9.5e6]
    │   └─ ← [Return] 9500000 [9.5e6]
    ├─ [0] console::log("teamWallet balance: ", 9500000 [9.5e6]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc) [delegatecall]
    │   │   └─ ← [Return] 500000 [5e5]
    │   └─ ← [Return] 500000 [5e5]
    ├─ [0] console::log("avatarWallet balance: ", 500000 [5e5]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0x0000000000000000000000000000000000000123) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0x0000000000000000000000000000000000000123) [delegatecall]
    │   │   └─ ← [Return] 30000000 [3e7]
    │   └─ ← [Return] 30000000 [3e7]
    ├─ [0] console::log("nftOwner balance: ", 30000000 [3e7]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [1339] 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [staticcall]
    │   ├─ [553] 0x43506849D7C04F9138D1A2050bbF3A0c054402dd::balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) [delegatecall]
    │   │   └─ ← [Return] 200000000 [2e8]
    │   └─ ← [Return] 200000000 [2e8]
    ├─ [0] console::log("recipient balance: ", 200000000 [2e8]) [staticcall]
    │   └─ ← [Stop] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 2.45s (2.45s CPU time)

Ran 1 test suite in 1283.99s (2.45s CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)