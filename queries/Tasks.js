import { MYSQL_CONFIG } from "../config.js";
import mysql from "mysql2/promise";
const NOW_TIMESTAMP = Math.floor(Date.now() / 1000);

const now_date = () => {
  return Math.floor(Date.now() / 1000);
}

export const get_need_pushed_task = async () => {
  try {
    const sql = "SELECT * FROM view_tg_task_need_send LIMIT 0,30"
    // const sql = "SELECT * FROM view_tg_task_need_send WHERE user_id = 5551242261 or user_id = 560285695"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const get_user_task_point = async (user_id) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM view_user_earn_point_b WHERE user_id = ?`
    const [rows, fields] = await connection.query(sql, [user_id]);
    await connection.end();
    if (rows.length === 0) {
      return 0;
    }
    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const mark_task_as_done = async (user_task_id) => {
  const complete_date = now_date();
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `UPDATE tg_daily_task SET is_completed = 1, is_reviewed = 1, earn_point=1, complete_date = ? WHERE id = ?`
    const [rows, fields] = await connection.query(sql, [complete_date, user_task_id]);
    await connection.end();
    return true
  } catch (error) {
    throw error;
  }
};

export const mark_task_as_done_with_proof = async (user_task_id, proof) => {
  const complete_date = now_date();
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `UPDATE tg_daily_task SET is_completed = 1, is_reviewed = 1,earn_point=1, complete_date = ?, user_proof = ? WHERE id = ?`
    const [rows, fields] = await connection.query(sql, [complete_date, proof, user_task_id]);
    await connection.end();

    return true;
  } catch (error) {
    throw error;
  }
};

export const mark_task_as_done_with_proof_need_verify = async (user_task_id, proof) => {
  const complete_date = now_date();
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `UPDATE tg_daily_task SET is_completed = 1, is_reviewed = 0,earn_point=0, complete_date = ?, user_proof = ? WHERE id = ?`
    const [rows, fields] = await connection.query(sql, [complete_date, proof, user_task_id]);
    await connection.end();

    return true;
  } catch (error) {
    throw error;
  }
};

export const get_user_task_uncompleted = async (user_id) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM view_tg_task_users WHERE user_id = ? AND is_completed = ? LIMIT 0,10`
    const [rows, fields] = await connection.query(sql,
      [user_id, 0]);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const get_user_task_completed = async (user_id) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM view_tg_task_users WHERE user_id = ? AND is_completed = ? LIMIT 0,10`
    const [rows, fields] = await connection.query(sql,
      [user_id, 1]);
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const get_user_task = async (user_id) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM view_tg_task_users WHERE user_id = ? LIMIT 0,10`
    const [rows, fields] = await connection.query(sql,
      [user_id]);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const get_task_by_id = async (id) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM view_tg_task_users WHERE id = ?`
    const [rows, fields] = await connection.query(sql,
      [id]);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const get_rank_table = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM tg_rank`
    const [rows, fields] = await connection.query(sql);
    await connection.end();
    return rows;
  } catch (error) {
    throw error;
  }
};

export const update_task_status_to_sent = async (id = 1) => {
  const now = Math.floor(Date.now() / 1000);
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `UPDATE tg_daily_task SET send_status=1, send_date=?  WHERE id=?`
    const [rows, fields] = await connection.query(sql, [now, id]);
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};
