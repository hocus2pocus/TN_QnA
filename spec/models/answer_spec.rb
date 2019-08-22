require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }
  it do
    should have_db_column(:user_id).
    with_options(null: false)
  end

  it { should validate_presence_of :body }
end
