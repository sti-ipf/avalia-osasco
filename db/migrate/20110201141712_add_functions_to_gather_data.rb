class AddFunctionsToGatherData < ActiveRecord::Migration
  def self.up
    execute %Q{
      CREATE FUNCTION answer_value(a0 int, a1 int,a2 int,a3 int,a4 int,a5 int ) returns int
      return if(a1 = 1,1,0)+if(a2 = 1,2,0)+if(a3 = 1,3,0)+if(a4 = 1,4,0)+if(a5 = 1,5,0);
    }
    
    execute %Q{
      CREATE FUNCTION answer_mean(a0 int, a1 int,a2 int,a3 int,a4 int,a5 int, part_number int ) returns int
      return answer_value(a0, a1, a2, a3, a4, a5) / part_number;
    }
  end

  def self.down
    execute "drop function answer_mean"
    execute "drop function answer_value"
  end
end
