class ConvertAttachmentToPolymorphic < ActiveRecord::Migration
  def change
    remove_index :attachments, :question_id
    rename_column :attachments, :question_id, :attachable_id
    add_index :attachments, :attachable_id
    add_column :attachments, :attachable_type, :string
    add_index :attachments, :attachable_type
  end
end
