import {Schema, model} from "mongoose";

const GroupSchema = new Schema(
  {
    id: Number,
    title: String,
    username: String,
    type: String,
    minRank: {
      type: Number,
      default: 1,
    },
  },
  {timestamps: true}
);

export default model("Group", GroupSchema);
