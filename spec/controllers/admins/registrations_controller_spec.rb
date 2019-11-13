require 'rails_helper'

describe Admins::RegistrationsController do
  
  let(:flocela_admin_attributes) do
    { "admin" => {
        "email" => "flocela@gmail.com",
        "password" => "very-secret",
        "password_confirmation" => "very-secret"
        }
    }
  end

  let(:abc_admin_attributes) do
    { "admin"  => {
        "email" => "abc@gmail.com",
        "password" => "very-secret",
        "password_confirmation" => "very-secret"
        }
    }
  end

  it 'allows flocela@gmail.com to register' do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    expect(Admin.count).to equal(0)
    post :create, params: flocela_admin_attributes
    expect(Admin.count).to equal(1)
  end
  
  it 'does not allow abc@gmail.com to register' do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    expect(Admin.count).to equal(0)
    post :create, params: abc_admin_attributes
    expect(Admin.count).to equal(0)
  end

end
