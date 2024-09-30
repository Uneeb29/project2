
import { get_user_rank_need_update } from "./queries/Rank.js";

const main = async () => {
  try {
    await get_user_rank_need_update();

  } catch (error) {
  }
}

const interval = 30 * 1000
main();
setInterval(() => {
  main();
}, interval);
