import { MYSQL_CONFIG } from "../config.js";
import mysql from "mysql2/promise";

const now_date = () => {
  return Math.floor(Date.now() / 1000);
}

export const get_rank_need_update = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const SQL = "SELECT * FROM tg_rank_change WHERE `is_processed` = 0"
    const [rows, fields] = await connection.query(SQL);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const update_processed_rank = async (id = 0, user_id = 0, new_rank = 0, tx_hash = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const SQL = "UPDATE tg_rank_change SET is_processed = 1, is_success = 1, tx_hash = ? WHERE `id` = ?"
    const SQL2 = " UPDATE tg_user SET nft_rank = ? WHERE id = ?"

    const [rows, fields] = await connection.query(SQL, [
      tx_hash, id
    ]);

    const [rows2, fields2] = await connection.query(SQL2, [
      new_rank, user_id
    ]);
    await connection.end();

    return true;
  } catch (error) {
    console.log(error);
    return false;
  }
};

export const get_user_rank_need_update = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const SQL = "INSERT IGNORE INTO `tg_rank_change` (user_id,old_rank,new_rank) SELECT a.user_id,a.nft_rank,a.rank_number FROM view_user_earn_pont_upgrade as a WHERE a.`nft_rank` <  a.`rank_number`"
    const [rows, fields] = await connection.query(SQL);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const get_user_rank_need_process = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const SQL = "SELECT * FROM `view_tg_rank_change` WHERE is_processed = 0 limit 0,1"
    const [rows, fields] = await connection.query(SQL);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  } catch (error) {
    console.log(error)
    return null;
  }
};

