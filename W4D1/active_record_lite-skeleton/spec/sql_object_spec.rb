require 'active_record_lite'
require 'securerandom'

describe SQLObject do
  before(:all) do
    # https://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
    cats_db_file_name =
      File.expand_path(File.join(File.dirname(__FILE__), "cats.db"))
    DBConnection.open(cats_db_file_name)

    class Cat < SQLObject
      set_table_name("cats")
      my_attr_accessible(:id, :name, :owner_id)
    end

    class Human < SQLObject
      set_table_name("humans")
      my_attr_accessible(:id, :fname, :lname, :house_id)
    end

    # p Human.find(1)
    # p Cat.find(1)
    # p Cat.find(2)

    # p Human.all
    # p Cat.all

    # c = Cat.new(:name => "Gizmo", :owner_id => 1)
    # c.save # create
    # c.save # update
  end

  it "#find finds objects by id" do
    c = Cat.find(1)
    expect(c).not_to be_nil
  end

  it "#saves saves changes to an object" do
    h = Human.find(1)
    n = h.fname
    h.fname = SecureRandom.urlsafe_base64(16)
    h.save
    n.should_not == Human.find(1).fname
  end
end