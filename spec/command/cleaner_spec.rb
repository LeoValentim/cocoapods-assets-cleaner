require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Cleaner do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ cleaner }).should.be.instance_of Command::Cleaner
      end
    end
  end
end

