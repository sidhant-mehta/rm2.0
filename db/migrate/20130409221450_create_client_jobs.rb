class CreateClientJobs < ActiveRecord::Migration
  def change
    create_table :client_jobs do |t|
      t.integer :client_id
      t.integer :job_id

      t.timestamps
    end
  end
end
