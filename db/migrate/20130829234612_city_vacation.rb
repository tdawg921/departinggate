class CityVacation < ActiveRecord::Migration
  def up
  	change_table :city_vacation_type_xref do |t|
  		t.integer :rating
  	end

  	execute <<-SQL
  	  	ALTER TABLE `dg_development`.`city_vacation_type_xref` 
      ADD CONSTRAINT `fk_city_vacation_city`
      FOREIGN KEY (`City_Code` )
      REFERENCES `dg_development`.`ref_city` (`id` )
      ON DELETE NO ACTION
      ON UPDATE NO ACTION, 
    ADD CONSTRAINT `fk_city_vacation_type`
      FOREIGN KEY (`Vacation_Type` )
      REFERENCES `dg_development`.`ref_vacation_type` (`Vacaton_Type_Code` )
      ON DELETE NO ACTION
      ON UPDATE NO ACTION 
    , ADD INDEX `fk_city_idx` (`City_Code` ASC) 
    , ADD INDEX `fk_type_idx` (`Vacation_Type` ASC) ;
		SQL
  end

  def down
  	change_table :city_vacation_type_xref do |t|
  		t.remove :rating
  	end
  	execute <<-SQL
	  	ALTER TABLE `dg_development`.`city_vacation_type_xref` 
	  	DROP FOREIGN KEY `fk_city` , DROP FOREIGN KEY `fk_type` ;
	  	SQL
	execute <<-SQL 
	 	ALTER TABLE `dg_development`.`city_vacation_type_xref` 
		DROP INDEX `fk_type_idx` 
		, DROP INDEX `fk_city_idx` ;
		SQL
  end
end
