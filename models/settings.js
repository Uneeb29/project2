import {Schema, model} from "mongoose";

const SettingsSchema = new Schema(
  {
    privateKey: String,
    nftAddress: String,
    isTestnet: Boolean,
    rpcUrl: String,
    allowedMode: Boolean,
  },
  {timestamps: true}
);

export default model("Settings", SettingsSchema);
