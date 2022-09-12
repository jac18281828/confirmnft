// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

import "forge-std/Test.sol";

import "../contracts/confirmnft.sol";
import "./MockERC721Enum.sol";

contract ConfirmTest is Test {
    using stdStorage for StdStorage;

    ConfirmNFT private _confirmNFT;

    uint256 immutable _tokenId = 0xf733b17d;
    address immutable _owner = address(0xffeeeeff);
    address immutable _notowner = address(0x55);
    address immutable _nobody = address(0x0);
    IERC721 _tokenContract;

    function setUp() public {
        _confirmNFT = new ConfirmNFT();

        MockERC721Enum merc721 = new MockERC721Enum();
        merc721.mintTo(_owner, _tokenId);
        _tokenContract = merc721;
    }

    function testConfirm() public {
        address contractAddress = address(_tokenContract);
        assertTrue(_confirmNFT.confirm(_owner, contractAddress, _tokenId));
    }

    function testNotOwner() public {
        address contractAddress = address(_tokenContract);
        assertFalse(_confirmNFT.confirm(_notowner, contractAddress, _tokenId));
    }

    function testConfirmDisco() public {
        address contractAddress = address(_tokenContract);
        vm.prank(_owner);
        _confirmNFT.emitConfirmedTokens(contractAddress);
    }

    function testDiscoNotOwner() public {
        address contractAddress = address(_tokenContract);
        vm.expectRevert("Token owner required");
        vm.prank(_notowner);
        _confirmNFT.emitConfirmedTokens(contractAddress);
    }
}
