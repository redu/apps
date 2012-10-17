require 'spec_helper'

describe ScreenShot do
  it { should have_attached_file(:screen) }
  it { should belong_to(:app) }
end
