class CreateSoapSessions < ActiveRecord::Migration
  def change
    create_table :soap_sessions do |t|
      t.string :session_id
      t.string :security_token
      t.string :timestamps

      t.timestamps
    end
  end
end
