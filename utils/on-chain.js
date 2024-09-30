import { ethers, Wallet, BigNumber as BN } from "ethers";
import { Provider } from "@fullstuck/multicall";
import Settings from "../models/settings.js";
import AdminAbi from "../abis/admin.json" assert {type: "json"};
import NFTAbi from "../abis/nft.json" assert {type: "json"};
import { createTxLink } from "./helper.js";
import { get_setting } from "../queries/Setting.js";

export const mintFreeNFT = async (address, rank = 1) => {
  const setting = await get_setting();
  const provider = new ethers.providers.JsonRpcProvider(setting.rpc_url);
  const wallet = new Wallet(setting.private_key, provider);

  const nftContract = new ethers.Contract(setting.nft_address, NFTAbi, wallet);
  try {
    const tx = await nftContract.mintSafe(address, rank);
    await tx.wait();
    return createTxLink(tx.hash, Boolean(setting.is_testnet));
  } catch (error) {
    const txx = await nftContract.balanceOf(address, rank);
    if (txx.toNumber() === 1) {
      return rank;
    }
    return "";
  }
};

export const giveFreeNFT = async (address, rank = 1) => {
  const setting = await get_setting();
  const provider = new ethers.providers.JsonRpcProvider(setting.rpc_url);
  const wallet = new Wallet(setting.private_key, provider);

  const nftContract = new ethers.Contract(setting.nft_address, NFTAbi, wallet);
  try {
    const [gasPrice, gasLimit] = await Promise.all([
      wallet.getGasPrice(),
      nftContract.estimateGas.mintSafe(address, rank)
    ])
    const tx = await nftContract.mintSafe(address, rank, {
      gasPrice,
      gasLimit
    });
    await tx.wait();
    return createTxLink(tx.hash, Boolean(setting.is_testnet));
  } catch (error) {
    const txx = await nftContract.balanceOf(address, rank);
    console.log({ txx });
    console.log({ error });
    if (txx.toNumber() === 1) {
      return rank;
    }
    return "";
  }
};

export const upgradeRank = async (address, oldRank = 1, newRank = 2) => {
  const setting = await get_setting();
  const provider = new ethers.providers.JsonRpcProvider(setting.rpc_url);
  const wallet = new Wallet(setting.private_key, provider);
  const nftContract = new ethers.Contract(setting.nft_address, NFTAbi, wallet);
  try {
    const [gasPrice, gasLimit] = await Promise.all([
      wallet.getGasPrice(),
      nftContract.estimateGas.upgradeRank(address, oldRank, newRank)
    ])
    const tx = await nftContract.upgradeRank(address, oldRank, newRank, {
      gasPrice,
      gasLimit
    });
    await tx.wait();

    return createTxLink(tx.hash, Boolean(setting.is_testnet));
  } catch (error) {
    console.log(error);
    return "";
  }
};

export const downgradeRank = async (address, oldRank = 2, newRank = 1) => {
  const setting = await get_setting();
  const provider = new ethers.providers.JsonRpcProvider(setting.rpc_url);
  const wallet = new Wallet(setting.private_key, provider);

  const nftContract = new ethers.Contract(setting.nft_address, NFTAbi, wallet);
  try {
    const tx = await nftContract.downgradeRank(address, oldRank, newRank);
    await tx.wait();

    return createTxLink(tx.hash, Boolean(setting.is_testnet));
  } catch (error) {
    return "";
  }
};

export const checkUserNFT = async (address, rank = 1) => {
  const setting = await get_setting();
  const provider = new ethers.providers.JsonRpcProvider(setting.rpc_url);
  const wallet = new Wallet(setting.private_key, provider);

  const nftContract = new ethers.Contract(setting.nft_address, NFTAbi, wallet);
  try {
    const a = await nftContract.balanceOf(address, rank);
    return a.toNumber();
  } catch (error) {
    console.log(error)
    return 0;
  }
};

export const removeUserNFT = async (address) => {
  const setting = await get_setting();
  const provider = new ethers.providers.JsonRpcProvider(setting.rpc_url);
  const wallet = new Wallet(setting.private_key, provider);

  const nftContract = new ethers.Contract(setting.nft_address, NFTAbi, wallet);
  try {
    const tx = await nftContract.burnAll(address);
    await tx.wait();

    return true;
  } catch (error) {
    return false;
  }
};
