import {Wallet, BigNumber as BN} from "ethers";
import crypto from "crypto";

const generatePkey = () => {
  return crypto.randomBytes(32).toString("hex");
};

export const generateWallet = () => {
  let pkey = generatePkey();
  const addr = new Wallet(pkey).address;

  return {
    privateKey: pkey,
    address: addr,
  };
};

export const privateKeyToAddress = (privatekey) => {
  const addr = new Wallet(privatekey).address;
  return addr;
};

export const validAddress = (str) => {
  return /^0x[a-fA-F0-9]{40}$/g.test(str);
};
