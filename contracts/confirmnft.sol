// SPDX-License-Identifier: BSD-3-Clause
/*
 * Copyright (c) 2022 John Cairns
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract ConfirmNFT {
    event ConfirmedOwner(
        address _wallet,
        address _nftContract,
        uint256 _tokenId,
        uint256 blockNumber
    );

    modifier requireValidAddress(address _wallet) {
        require(_wallet != address(0), "Not a valid wallet");
        _;
    }

    modifier requireValidTokenId(uint256 _tokenId) {
        require(_tokenId != 0, "Token not valid");
        _;
    }

    function discover(address _wallet, address _nftContract)
        external
        view
        requireValidAddress(_nftContract)
        returns (uint256[] memory)
    {
        IERC721 _nft = IERC721(_nftContract);
        bytes4 interfaceId721 = type(IERC721Enumerable).interfaceId;
        require(
            _nft.supportsInterface(interfaceId721),
            "ERC-721 Enumerable required"
        );
        IERC721Enumerable enumContract = IERC721Enumerable(_nftContract);

        uint256 tokenBalance = _nft.balanceOf(_wallet);
        require(tokenBalance > 0, "Token owner required");
        uint256[] memory tokenIdList = new uint256[](tokenBalance);
        for (uint256 i = 0; i < tokenBalance; i++) {
            tokenIdList[i] = enumContract.tokenOfOwnerByIndex(_wallet, i);
        }
        return tokenIdList;
    }

    function confirm(
        address _owner,
        address _nftContract,
        uint256 _tokenId
    )
        external
        view
        requireValidAddress(_nftContract)
        requireValidTokenId(_tokenId)
        returns (bool)
    {
        IERC721 _nft = IERC721(_nftContract);
        if (_nft.ownerOf(_tokenId) == _owner) {
            return true;
        } else {
            return false;
        }
    }

    function emitConfirmedTokens(address _nftContract) external {
        address _owner = msg.sender;
        uint256[] memory _tokenList = this.discover(_owner, _nftContract);
        for (uint256 i = 0; i < _tokenList.length; i++) {
            uint256 tokenId = _tokenList[i];
            if (!this.confirm(_owner, _nftContract, tokenId)) {
                revert("Not token owner");
            }
            emit ConfirmedOwner(_owner, _nftContract, tokenId, block.number);
        }
    }
}
