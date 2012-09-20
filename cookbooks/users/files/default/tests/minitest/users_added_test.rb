require 'minitest/spec'

describe_recipe 'users::sysadmin' do

  # It's often convenient to load these includes in a separate helper along with
  # your own helper methods, but here we just include them directly:
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "users and groups" do

    # Check if a user has been created:
    it "creates the thehar user" do
      user("thehar").must_exist
    end

    it "has the expected uid" do
      user("thehar").must_have(:uid, 1337)
    end

    it "has the expected gid" do
      user("thehar").must_have(:gid, 1337)
    end

    it "creates the sysadmin group" do
      group("sysadmin").must_exist
    end

    # Check for group membership, you can pass a single user or an array of
    # users:
    it "grants group membership to the expected users" do
      group("sysadmin").must_include('thehar')
    end

    it "sysadmin has a private key in .ssh" do
      file("/home/thehar/.ssh/id_rsa").must_exist
    end

    it 'thehar pub keys are in authorized_keys' do
      Dir.glob("/home/thehar/.ssh/*.pub").each do |pub_key|
        file("/home/thehar/.ssh/authorized_keys").must_include File.read(pub_key)
      end
    end
  end
end
