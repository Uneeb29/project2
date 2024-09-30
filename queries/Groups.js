import { MYSQL_CONFIG } from "../config.js";
import mysql from "mysql2/promise";
const TABLE_NAME = "tg_group";

export const get_group = async (id = 0) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const sql = `SELECT * FROM ${TABLE_NAME} WHERE \`id\` = ?`
    const [rows, fields] = await connection.query(sql, [id]);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }

    return rows[0];
  } catch (error) {
    throw error;
  }
};

export const get_all_group = async () => {
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

export const get_all_zero_group = async () => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`SELECT * FROM tg_group WHERE minimum_rank is NULL OR minimum_rank = 0`);
    await connection.end();
    if (rows.length === 0) {
      return null;
    }
    return rows;
  } catch (error) {
    throw error;
  }
};

export const update_minimum_rank = async (id = 0, minimum_rank = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`minimum_rank\` = ? WHERE \`id\` = ?`, [minimum_rank, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const update_group_id = async (id = 0, new_id = 1) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `UPDATE ${TABLE_NAME} SET \`id\` = ?, \`old_id\` = ?  WHERE \`id\` = ?`, [new_id, id, id]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const delete_group = async (id = 0) => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(`DELETE FROM ${TABLE_NAME} WHERE \`id\` = ?`, [id]);
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const insert_group = async (id = 1, title = "", username = "") => {
  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `INSERT INTO ${TABLE_NAME} (\`id\`, \`title\`, \`username\`) VALUES (?, ?, ?)`, [id, title, username]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};

export const insert_migrate_group = async (data) => {
  let { id, title, username, minRank } = data;

  id = typeof id === "undefined" ? 0 : id;
  title = typeof title === "undefined" ? null : title;
  username = typeof username === "undefined" ? null : username;
  minRank = typeof minRank === "undefined" ? 1 : minRank;

  try {
    const connection = await mysql.createConnection(MYSQL_CONFIG);
    const [rows, fields] = await connection.query(
      `INSERT INTO ${TABLE_NAME} (\`id\`, \`title\`, \`username\`, \`minimum_rank\`) VALUES (?, ?, ?, ?)`,
      [id, title, username, minRank]
    );
    await connection.end();
    return true;
  } catch (error) {
    throw error;
  }
};
