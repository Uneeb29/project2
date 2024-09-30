import { MYSQL_CONFIG } from "../config.js";
import mysql from "mysql2/promise";
const NOW_TIMESTAMP = Math.floor(Date.now() / 1000);

const now_date = () => {
  return Math.floor(Date.now() / 1000);
}

export const get_active_campaign = async () => {
  try {
    const sql = "SELECT * FROM tg_campaign WHERE is_active=1"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql);
    await connection.end();
    if (rows.length > 0) {
      return rows;
    }
    return null;
  } catch (error) {
    throw error;
  }
};

export const get_campaign_by_id = async (campaign_id) => {
  try {
    const sql = "SELECT * FROM tg_campaign WHERE id = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [campaign_id]);
    await connection.end();
    if (rows.length === 1) {
      return rows[0];
    }
    return null;
  } catch (error) {
    throw error;
  }
};
export const get_active_campaign_by_id = async (campaign_id) => {
  try {
    const sql = "SELECT * FROM tg_campaign WHERE is_active=1 AND id=?";
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [campaign_id]);
    await connection.end();
    if (rows.length > 0) {
      return rows[0];
    }
    return null;
  } catch (error) {
    throw error;
  }
};

export const get_campaign_tasks_users = async (campaign_id, task_order) => {

  try {
    const sql = "SELECT * FROM tg_campaign_task WHERE campaign_id = ? AND `task_order` = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [campaign_id, task_order]);
    await connection.end();
    if (rows.length > 0) {
      return rows[0];
    }
    return null;
  } catch (error) {
    throw error;
  }
};

export const get_campaign_num_task = async (campaign_id) => {

  try {
    const sql = "SELECT count(id) as task_count FROM tg_campaign_task WHERE campaign_id = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [campaign_id]);
    await connection.end();
    return rows[0].task_count === null ? 0 : rows[0].task_count;
  } catch (error) {
    throw error;
  }
};

export const get_campaign_tasks_user_step = async (campaign_id, user_id) => {

  try {
    const sql = "SELECT * FROM view_campaign_user_step WHERE campaign_id = ? AND user_id = ? ORDER BY task_order DESC"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [campaign_id, user_id]);
    await connection.end();
    if (rows.length > 0) {
      if (rows[0].is_done === 1) {
        return Number(rows[0].task_order) + 1
      }
      return rows[0].task_order;
    }
    return 1;
  } catch (error) {
    throw error;
  }
};

export const insert_campaign_task_user = async (campaign_task_id, user_id) => {
  try {
    const sql = "INSERT IGNORE INTO tg_campaign_task_user (campaign_task_id, user_id, is_done, created_at) VALUES (?,?,?,?)"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [Number(campaign_task_id), user_id, 0, now_date()]);
    await connection.end();

    return true;
  } catch (error) {
    throw error;
  }
}

export const mark_campaign_task_done = async (campaign_task_id, user_id) => {
  try {
    const sql = "UPDATE tg_campaign_task_user SET is_done = ?, done_at = ? WHERE campaign_task_id = ? AND user_id = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [1, now_date(), campaign_task_id, user_id]);
    await connection.end();

    return true;
  } catch (error) {
    throw error;
  }
}

export const mark_campaign_task_done_proof = async (campaign_task_id, user_id, proof) => {
  try {
    const sql = "UPDATE tg_campaign_task_user SET is_done = ?, done_at = ?, proof = ? WHERE campaign_task_id = ? AND user_id = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [1, now_date(), proof, campaign_task_id, user_id]);
    await connection.end();

    return true;
  } catch (error) {
    throw error;
  }
}


export const mark_campaign_user_done = async (campaign_id, user_id) => {
  try {
    const sql = "INSERT IGNORE INTO tg_campaign_task_user (campaign_id, user_id, created_at) VALUES (?,?,?)"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [campaign_id, user_id, now_date()]);
    await connection.end();

    return true;
  } catch (error) {
    throw error;
  }
}

export const get_notification_to_user = async () => {
  try {
    const sql = "SELECT * FROM tg_user_send_notification WHERE is_processed=0 LIMIT 0,30"
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
}

export const update_notification_to_user = async (id) => {
  try {
    const sql = "UPDATE tg_user_send_notification SET is_processed = 1, sent_at=? WHERE id=?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [now_date(), id]);
    return true;
  } catch (error) {
    throw error;
  }
}

export const check_if_blacklisted = async (user_id) => {
  try {
    const sql = "SELECT * FROM blacklist WHERE telegram_handle = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [String(user_id)]);
    await connection.end();
    console.log("got: ", rows)
    console.log()
    if (rows.length > 0) {
      return true;
    }
    return false;
  } catch (error) {
    throw error;
  }
}

export const get_leaderboard = async (user_id) => {
  try {
    const sql = "SELECT user_id, user_point FROM view_user_earn_point_alltime WHERE user_id = ?"
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(sql, [user_id]);
    await connection.end();
    if (rows.length > 0) {
      return rows[0];
    }
    return null;
  }
  catch (error) {
    throw error;
  }
}
