import {Schema, model} from "mongoose";

const UsersSchema = new Schema(
  {
    id: {type: Number, index: true},
    first_name: String,
    last_name: String,
    username: String,
    privateKey: String,
    email: String,
    address: {type: String, index: true},
    owner_address: {type: String, index: true},
    rank: {
      type: Number,
      default: 0,
    },
    is_premium: Boolean,
    isBanned: Boolean,
    groups: [Number],
    seen: Date,
  },
  {timestamps: true}
);

export default model("Users", UsersSchema);
