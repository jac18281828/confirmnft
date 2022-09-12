// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/interfaces/IERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract MockERC721Enum is IERC721, IERC721Enumerable {
    uint256 private _totalCount = 0;
    mapping(uint256 => uint256) private _tokenSupply;
    mapping(address => OwnerSupply) private _ownerSupply;
    mapping(address => uint256) _ownerBalanceMap;
    mapping(uint256 => address) _tokenMap;

    struct OwnerSupply {
        uint256 _totalCount;
        mapping(uint256 => uint256) _supply;
    }

    modifier tokenExists(uint256 _tokenId) {
        require(_tokenMap[_tokenId] != address(0x0), "Token does not exist");
        _;
    }

    modifier tokenDoesNotExist(uint256 _tokenId) {
        require(_tokenMap[_tokenId] == address(0x0), "Token exists");
        _;
    }

    modifier tokenOwnedBy(uint256 _tokenId, address _owner) {
        require(_tokenMap[_tokenId] == _owner, "Not token owner");
        _;
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return _ownerBalanceMap[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenMap[_tokenId];
        if (owner == address(0)) {
            revert("token does not exist");
        }
        return owner;
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes calldata /* data */
    ) external tokenExists(_tokenId) tokenOwnedBy(_tokenId, _from) {
        require(_from == msg.sender, "Not token owner");
        _ownerBalanceMap[_from] -= 1;
        _ownerBalanceMap[_to] += 1;
        _tokenMap[_tokenId] = _to;
    }

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external tokenExists(_tokenId) tokenOwnedBy(_tokenId, _from) {
        require(_from == msg.sender, "Not token owner");
        _ownerBalanceMap[_from] -= 1;
        _ownerBalanceMap[_to] += 1;
        _tokenMap[_tokenId] = _to;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external {
        require(_from == msg.sender, "Not token owner");
        _ownerBalanceMap[_from] -= 1;
        _ownerBalanceMap[_to] += 1;
        _tokenMap[_tokenId] = _to;
    }

    function approve(
        address, /* to */
        uint256 /*tokenId*/
    ) external pure {
        revert("Not implemented");
    }

    function setApprovalForAll(
        address, /* operator */
        bool /* _approved */
    ) external pure {
        revert("Not implemented");
    }

    function getApproved(
        uint256 /* tokenId */
    ) external pure returns (address) {
        revert("Not implemented");
    }

    function isApprovedForAll(
        address, /* owner */
        address /* operator */
    ) external pure returns (bool) {
        revert("Not implemented");
    }

    function mintTo(address _owner, uint256 _tokenId)
        public
        tokenDoesNotExist(_tokenId)
    {
        _ownerBalanceMap[_owner] += 1;
        _tokenMap[_tokenId] = _owner;
        _tokenSupply[_totalCount] = _tokenId;
        OwnerSupply storage ownerSupply = _ownerSupply[_owner];
        uint256 index = ownerSupply._totalCount++;
        ownerSupply._supply[index] = _tokenId;
        _totalCount++;
    }

    function totalSupply() external view returns (uint256) {
        return _totalCount;
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index)
        external
        view
        returns (uint256)
    {
        OwnerSupply storage ownerSupply = _ownerSupply[_owner];
        require(_index < ownerSupply._totalCount, "Invalid token index");
        return ownerSupply._supply[_index];
    }

    function tokenByIndex(uint256 index) external view returns (uint256) {
        require(index < _totalCount, "Invalid token index");
        return _tokenSupply[index];
    }

    function supportsInterface(bytes4 interfaceId)
        external
        pure
        virtual
        override(IERC165)
        returns (bool)
    {
        return
            interfaceId == type(IERC721Enumerable).interfaceId ||
            interfaceId == type(IERC721).interfaceId;
    }
}
