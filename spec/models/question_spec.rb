require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to :user }
  it do
    should have_db_column(:user_id).
    with_options(null: false)
  end

  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
end
