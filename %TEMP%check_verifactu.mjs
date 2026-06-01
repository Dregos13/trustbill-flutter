import pg from 'pg';
const { Client } = pg;
const client = new Client({
  host: 'billing-db.cdussui4sh3i.eu-west-1.rds.amazonaws.com',
  port: 5432,
  database: 'trustcore_db',
  user: 'postgres',
  password: process.env.DB_PASS,
  ssl: { rejectUnauthorized: false }
});
await client.connect();

const submissions = await client.query(`
  SELECT id, "companyId", env, "createdAt", "statusGlobal"
  FROM "VerifactuSubmission"
  ORDER BY "createdAt" DESC
  LIMIT 10
`);
console.log('=== VerifactuSubmission (últimas 10) ===');
console.table(submissions.rows);

const records = await client.query(`
  SELECT id, "companyId", "recordType", status, "submissionId", "createdAt"
  FROM "VerifactuRecordQueue"
  ORDER BY "createdAt" DESC
  LIMIT 10
`);
console.log('=== VerifactuRecordQueue (últimas 10) ===');
console.table(records.rows);

await client.end();
