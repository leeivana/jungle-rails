require 'rails_helper'

RSpec.describe User, type: :model do
 let(:user) do
    User.create!(
      first: 'user1',
      last: 'user1',
      email: 'user@hotmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  let(:user2) do
    User.create!(
      first: 'user2',
      last: 'user2',
      email: 'user@hotmail.com',
      password: 'password',
      password_confirmation: 'password',
    )
  end

  it 'should be valid if all params are present' do
    expect(user).to be_valid
  end

  it 'should not be valid if first name is not present' do
    user.first = ''
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if last name is not present' do
    user.last = ''
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if email is not present' do
    user.email = ''
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if password is not present' do
    user.password = nil
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if password_confirmation is not present' do
    user.password_confirmation = nil
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if password is not the same as password_confirmation' do
    user.password_confirmation = 'notSamePassword'
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if it does not password of atleast 6 characters' do
    user.password = 'hi'
    user.password_confirmation = 'hi'
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not be valid if password exceeds 15 chars ' do
    user.password ='hihihihihihihihihihi'
    user.password_confirmation = 'hihihihihihihihihihi'
    expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  # it 'should not be valid if email is not unique' do
  #   user2.email = user.password.upcase
  #   expect { user2.save }.to raise_error(ActiveRecord::RecordInvalid)
  # end

  describe '.authenticate_with_credentials' do
  end

end
