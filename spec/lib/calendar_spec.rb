require 'calendar'
require 'date'
require 'active_support/core_ext/date/calculations'
require 'active_support/core_ext/date/acts_like'
require 'active_support/core_ext/time/calculations'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/array/grouping'
require 'active_support/core_ext/string/conversions'

describe Calendar do
  let(:today) { '2012-12-12' }
  subject { Calendar.new(today) }

  context "#initialize" do
    it "should parse valid date" do
      subject.date.should == Date.parse(today)
    end

    it "should set today if parsing failed" do
      Calendar.new('Invalid date').date.should == Date.today
    end
  end

  context "#start_date" do
    it "should be beginning of month" do
      subject.start_date.should == Date.parse('2012-12-01')
    end
  end

  context "#end_date" do
    it "should be end of month" do
      subject.end_date.should == Date.parse('2012-12-31')
    end
  end

  context "#weeks" do
    it "should be calendar" do
      subject.weeks.should == [
        ['2012-11-26', '2012-11-27', '2012-11-28', '2012-11-29', '2012-11-30', '2012-12-01', '2012-12-02'],
        ['2012-12-03', '2012-12-04', '2012-12-05', '2012-12-06', '2012-12-07', '2012-12-08', '2012-12-09'],
        ['2012-12-10', '2012-12-11', '2012-12-12', '2012-12-13', '2012-12-14', '2012-12-15', '2012-12-16'],
        ['2012-12-17', '2012-12-18', '2012-12-19', '2012-12-20', '2012-12-21', '2012-12-22', '2012-12-23'],
        ['2012-12-24', '2012-12-25', '2012-12-26', '2012-12-27', '2012-12-28', '2012-12-29', '2012-12-30'],
        ['2012-12-31', '2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04', '2013-01-05', '2013-01-06']
      ].map do |week|
        week.map(&:to_date)
      end
    end
  end

  context "#working_days" do
    it "should be days from Monday to Friday" do
      subject.working_days.should == [
        "2012-12-03", "2012-12-04", "2012-12-05", "2012-12-06", "2012-12-07",
        "2012-12-10", "2012-12-11", "2012-12-12", "2012-12-13", "2012-12-14",
        "2012-12-17", "2012-12-18", "2012-12-19", "2012-12-20", "2012-12-21",
        "2012-12-24", "2012-12-25", "2012-12-26", "2012-12-27", "2012-12-28",
        "2012-12-31"
      ].map(&:to_date)
    end
  end

  context "#vacations" do
    it "should return vacation days" do
      Calendar::Day.should_receive(:vacations).with(subject.start_date, subject.end_date).and_return('vacations')
      subject.vacations.should == 'vacations'
    end
  end

  context "#worked_days" do
    it "should return working days without vacations" do
      subject.stub(:working_days).and_return(['one', 'two', 'three', 'four'])
      subject.stub(:vacations).and_return({'one' => true, 'three' => true})

      subject.worked_days.should == ['two', 'four']
    end
  end

  context '#css_classes' do
    before do
      subject.stub(:vacations).and_return({})
    end

    it "should return classes for today" do
      subject.css_classes(Date.today).should =~ /current/
    end

    it "should return classes for weekend" do
      subject.css_classes(Date.parse("2012-12-08")).should == 'na'
    end

    it "should return classes for dayoff" do
      subject.stub(:vacations).and_return({"2012-12-06".to_date => true})
      subject.css_classes(Date.parse("2012-12-06")).should == 'dayoff'
    end
  end
end

class Calendar
  class Day; end
end
