# README

## Project Details

This project consists of two separate Github repos:

1. web3_donations: A Hardhat.js project which allows for the deployment of a Charity.sol smart contract to the Ethereum test network Sepolia. The app uses the Alchemy API to deploy the smart contract to the Ethereum test network. You can take a closer look at contracts/Charity.sol for details on the smart contract implementation.

- The charity smart contract was deployed to the Ethereum test network Sepolia and can be found at this [link](https://sepolia.etherscan.io/address/0x1546df7edfa3c8a5bbdfbdd20c0f0ea6dfb8a50b)
- The source code can be found at this [Github repository address](https://github.com/StephanYu/web3_donation)

2. charity_dapp: A Rails 7 app that allows for crypto donations to the above Charity.sol smart contract via a Web3 wallet. Please take a look at the stimulus controller in javascript/metamask_controller.js for more details on the web3 integration with Metamask. The main app fetches a list of top movies from the IMDB-Top-100 API found on Rapid-API during the database seeding stage and stores the film details in a Postgres database. Details can be found in the db/seeds.rb file. I chose a simple third party API's for this project.

- The link to the IMDB-Top-100 API can be found at this link [here](https://rapidapi.com/rapihub-rapihub-default/api/imdb-top-100-movies).
- [Github repository address](https://github.com/StephanYu/nifty_fox_studios)

## Web3 Wallet

Similar to how traditional web2 portals require some sort of user authentication like email login credentials, web3 applications usually require users to own a web3 wallet.
There are many different wallets you can choose from, but for the sake of this project I would recommend MetaMask, which is, by far, the most popular Blockchain wallet used to store crypto and connect to decentralized Applications.
Blockchain Wallets are completely anonymous and you won’t need your email or any personal information to create your Metamask wallet.
Alchemy offers detailed instructions on how to install Metamask on your machine.

- Instructions can be found [here](https://docs.alchemy.com/docs/how-to-create-a-metamask-wallet).

## Test ETH for the Ethereum Test Network Sepolia

Once the wallet has been successfully installed and setup, please obtain some test ETH for the Sepolia network via the faucet website found [here](https://sepoliafaucet.com/). Enter the address of your newly setup web3 wallet to receive test crypto tokens. Detailed instructions on how to obtain test ETH tokens can be found on that same page.

!!! DO NOT use any real funds (USD, EUR, etc.) to fund your wallet. DO NOT transfer real ETH to the test wallet address either as you won't be able to recover them.

## Movies and Reviews

The app consists of only two models with a straight-forward one-to-many relationship:

- Movie
- Review

The Movie model uses ActiveStorage for storing its main image.
The most obvious shortcoming of the app is the lack of a User model and auth functionality which means that any user can edit movies or write reviews without any restrictions.

## Key points summarised

- No authentication and no authorisation

- Limited CRUD functionality

- Basic UI using Tailwind CSS

- Postgres Database

- Edit Movies

- Create Reviews

- Named URLs using slugs

- Images stored via ActiveStorage

- IMDB-Top-100 API from Rapid-API

- Alchemy API for smart contract deployment

- Integration with Metamask Web3 Wallet for ETH donations

## How to set up the dev environment

1. Clone the Github repo from here:

2. All external API secret access keys have been encrypted via Rails. You can obtain your own API key for the IMDB-Top-100 by simply registering on the Rapid API platform.

First, run rails credentials:edit to open a temporary file in your default editor. It uses the value of the EDITOR environment variable to determine your default editor. If nothing happens, you can set the EDITOR variable when running the command. For example, if VS Code is your preferred editor, then run

EDITOR="code --wait" rails credentials:edit

Then add the following credentials to the file replacing the ALL_CAPS variables with your newly obtained credentials.

rapidapi:
imdb100_url: <YOUR_API_URL>
imdb100_key: <YOUR_API_KEY>
imdb100_host: <YOUR_API_HOST>
