// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title ComputeMarket
 * @dev Manages auctions and leases for decentralized compute resources.
 */
contract ComputeMarket is ReentrancyGuard {
    struct Deployment {
        address tenant;
        string manifestHash; // Hardware requirements
        bool active;
    }

    struct Bid {
        address provider;
        uint256 pricePerBlock;
        bool accepted;
    }

    mapping(uint256 => Deployment) public deployments;
    mapping(uint256 => Bid[]) public bids;
    uint256 public nextDeploymentId;

    event DeploymentCreated(uint256 indexed id, address indexed tenant);
    event BidSubmitted(uint256 indexed deploymentId, address indexed provider, uint256 price);
    event LeaseStarted(uint256 indexed deploymentId, address indexed provider);

    function createDeployment(string calldata _manifestHash) external {
        deployments[nextDeploymentId] = Deployment(msg.sender, _manifestHash, true);
        emit DeploymentCreated(nextDeploymentId++, msg.sender);
    }

    function submitBid(uint256 _deploymentId, uint256 _price) external {
        require(deployments[_deploymentId].active, "Deployment not active");
        bids[_deploymentId].push(Bid(msg.sender, _price, false));
        emit BidSubmitted(_deploymentId, msg.sender, _price);
    }

    /**
     * @dev Tenant accepts a bid to start the lease.
     */
    function acceptBid(uint256 _deploymentId, uint256 _bidIndex) external payable {
        Deployment storage d = deployments[_deploymentId];
        require(msg.sender == d.tenant, "Only tenant");
        require(msg.value > 0, "Must fund escrow");

        Bid storage b = bids[_deploymentId][_bidIndex];
        b.accepted = true;
        d.active = false; // Close the auction

        emit LeaseStarted(_deploymentId, b.provider);
    }
}
