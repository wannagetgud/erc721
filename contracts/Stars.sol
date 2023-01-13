// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Stars is ERC721, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint256 public MINT_PRICE = 0.05 ether;
    uint public MAX_SUPPLY = 10;

    constructor() ERC721("Starry Eye", "SENFT") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmWA5FpRg6SYQDJHKHYwU78YEyFUbh5WZCgxiH54Sryjus/";
    }

    function safeMint(address to) public payable {
        // Check that totalSupply is less than MAX_SUPPLY
        require(totalSupply() < MAX_SUPPLY, "Can't mint anymore tokens.");
        // Check if ether value is enough
        require(msg.value >= MINT_PRICE, "Not enough ether sent.");

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
