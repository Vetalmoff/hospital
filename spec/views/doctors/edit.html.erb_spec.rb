require 'rails_helper'

RSpec.describe "doctors/edit", type: :view do
  before(:each) do
    @doctor = assign(:doctor, Doctor.create!(
      name: "MyString",
      position: "MyString"
    ))
  end

  it "renders the edit doctor form" do
    render

    assert_select "form[action=?][method=?]", doctor_path(@doctor), "post" do

      assert_select "input[name=?]", "doctor[name]"

      assert_select "input[name=?]", "doctor[position]"
    end
  end
end
