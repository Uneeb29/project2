import { MYSQL_CONFIG } from "../config.js";
import mysql from "mysql2/promise";
import { Bot } from "grammy";
import { BOT_TOKEN } from "../config.js";
const TABLE_NAME = "tg_user";

const bot = new Bot(BOT_TOKEN);


export const get_users = async (id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`SELECT * FROM ${TABLE_NAME} WHERE \`id\` = ?`, [id]);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const get_all_users = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`SELECT * FROM ${TABLE_NAME}`);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const get_users_stats = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`SELECT * FROM view_tg_user_statistic`);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const get_users_blocked = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`SELECT count(id) as jml FROM tg_user WHERE blocked_me =1`);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const get_user_groups = async (id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`SELECT * FROM tg_user_group WHERE \`user_id\` = ?`, [id]);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const kick_user_group = async (id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`DELETE FROM tg_user_group WHERE \`user_id\` = ?`, [id]);
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const user_join_group = async (user_id = 1, group_id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `INSERT INTO tg_user_group (user_id,group_id) VALUES (?, ?)`, [user_id, group_id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const remove_user_group = async (id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`DELETE FROM tg_user_group WHERE \`id\` = ?`, [id]);
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_email = async (id = 1, email = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`email\` = ? WHERE \`id\` = ?`, [email, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_twitter = async (id = 1, twitter = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`twitter\` = ? WHERE \`id\` = ?`, [twitter, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};




export const update_user_task_notification = async (id = 1, enable_task = 0) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`enable_task\` = ? WHERE \`id\` = ?`, [enable_task, id]
    );

    // Fetch user's chat_id from the database
    const [userRows] = await connection.query(
      `SELECT user_id, first_name FROM ${TABLE_NAME} WHERE \`id\` = ?`, [id]
    );
    const user = userRows[0];
    const chatId = user.user_id;
    const firstName = user.first_name;

    // Send a message based on enable_task value
    const messageText = enable_task
      ? `Hello ${firstName}, thank you for your good conduct! Keep it up!`
      : `Hello ${firstName}, please improve your conduct to continue receiving tasks.`;

    await bot.api.sendMessage(user_id, messageText, {
      parse_mode: "HTML",
    });

    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const insert_user = async (data) => {
  let { id, username, first_name, last_name, language_code, private_key, generated_address, nft_rank } = data;

  id = typeof id !== "undefined" ? id : 0;
  username = typeof username !== "undefined" ? username : null;
  first_name = typeof first_name !== "undefined" ? first_name : null;
  last_name = typeof last_name !== "undefined" ? last_name : null;
  language_code = typeof language_code !== "undefined" ? language_code : null;
  private_key = typeof private_key !== "undefined" ? private_key : null;
  generated_address = typeof generated_address !== "undefined" ? generated_address : null;
  nft_rank = typeof nft_rank !== "undefined" ? nft_rank : 0;

  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `INSERT IGNORE INTO ${TABLE_NAME} (id,username,first_name,last_name,language_code,private_key,generated_address,nft_rank,enable_task) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)`,
      [id, username, first_name, last_name, language_code, private_key, generated_address, nft_rank, 1]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const insert_migrate_user = async (data) => {
  let { id, username, first_name, last_name, language_code, privateKey, address, rank } = data;

  id = typeof id !== "undefined" ? id : 1;
  username = typeof username !== "undefined" ? username : null;
  first_name = typeof first_name !== "undefined" ? first_name : null;
  last_name = typeof last_name !== "undefined" ? last_name : null;
  language_code = typeof language_code !== "undefined" ? language_code : null;
  privateKey = typeof privateKey !== "undefined" ? privateKey : null;
  address = typeof address !== "undefined" ? address : null;
  rank = typeof rank !== "undefined" ? rank : 0;

  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `INSERT IGNORE INTO ${TABLE_NAME} (id,username,first_name,last_name,language_code,private_key,generated_address,nft_rank) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [id, username, first_name, last_name, language_code, privateKey, address, rank]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_private_key = async (id = 1, private_key = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`private_key\` = ? WHERE \`id\` = ?`, [private_key, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_generated_address = async (id = 1, generated_address = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`generated_address\` = ? WHERE \`id\` = ?`, [generated_address, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_owner_address = async (id = 1, owner_address = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`owner_address\` = ? WHERE \`id\` = ?`, [owner_address, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_nft_rank = async (id = 1, nft_rank = 0) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`nft_rank\` = ? WHERE \`id\` = ?`, [nft_rank, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_user_banned_me = async (id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`banned_me\` = 1 WHERE \`id\` = ?`, [id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};



// const userCache = {};

// export const checkEnableTask = async() => {
//   const connection = await mysql.createConnection(MYSQL_CONFIG);
//   connection.query('SELECT id, email, enable_task FROM tg_user', (error, results, fields) => {
//     if (error) throw error;

//     results.forEach(user => {
//       const { id, email, enable_task } = user;
//       if (userCache[id] !== undefined && userCache[id] !== enable_task) {
//         if (enable_task == 1) {
//           sendEmail(email, 'Good Conduct', 'Dear user, your conduct has been exemplary.');
//         } else {
//           sendEmail(email, 'Bad Conduct', 'Dear user, your conduct needs improvement.');
//         }
//       }
//       // Update the cache with the current state
//       userCache[id] = enable_task;
//     });
//   });
// }

// // Schedule the task to run periodically (every minute in this example)
// cron.schedule('* * * * *', () => {
//   console.log('Checking enable_task column...');
//   checkEnableTask();
// });
