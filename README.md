# Decentralized Computing Marketplace (Akash-style)

A professional-grade implementation for a "DeCloud" (Decentralized Cloud). This repository provides a censorship-resistant alternative to AWS/GCP. By utilizing a reverse auction model, it drives down the price of compute. Providers lease out their spare data center capacity, and tenants pay only for the resources their containers consume.

## Core Features
* **Reverse Auction Engine:** Providers compete to offer the lowest price for a tenant's deployment request.
* **Lease Management:** Automates the lifecycle of a deployment, including funding, active state tracking, and closure.
* **Escrow Payments:** Funds are locked in escrow and streamed to the provider based on the duration of the active lease.
* **Flat Architecture:** Single-directory layout for the Deployment Registry, Auction Manager, and Lease Escrow.

## Logic Flow
1. **Create:** A Tenant submits a "Deployment" specifying resource needs (e.g., 4 vCPU, 16GB RAM).
2. **Bid:** Cloud Providers see the deployment and submit "Bids" (e.g., $0.10/hour).
3. **Accept:** The Tenant selects a bid, creating an active "Lease."
4. **Stream:** The Tenant's escrowed funds are gradually released to the Provider as the container runs.

## Setup
1. `npm install`
2. Deploy `ComputeMarket.sol`.
