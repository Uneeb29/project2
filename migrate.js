import mongoose from "mongoose";
import {DATABASE_URL} from "./arborconfig.js";
import Users from "./models/users.js";
import {mintFreeNFT} from "./utils/on-chain.js";
import {insert_migrate_user} from "./queries/User.js";
import Groups from "./models/groups.js";
import {insert_migrate_group} from "./queries/Groups.js";

await mongoose.connect(DATABASE_URL, {
  useUnifiedTopology: true,
  useNewUrlParser: true,
});

console.log("Connected to database the server.");

const group = await Groups.find({});
// const user = await Users.find({});

for (let i = 0; i < group.length; i++) {
  await insert_migrate_group(group[i]);
}

console.log(group);
