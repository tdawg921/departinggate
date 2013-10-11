class RefCityFk < ActiveRecord::Migration
  def change
  	execute <<-SQL
  	  	ALTER TABLE `dg_development`.`ref_city_region` 
  		ADD CONSTRAINT `fk_city`
  		FOREIGN KEY (`ref_city_id` )
  		REFERENCES `dg_development`.`ref_city` (`id` )
  		ON DELETE NO ACTION
  		ON UPDATE NO ACTION, 
 		ADD CONSTRAINT `fk_region`
  		FOREIGN KEY (`ref_region_id` )
  		REFERENCES `dg_development`.`ref_region` (`Region_Code` )
  		ON DELETE NO ACTION
  		ON UPDATE NO ACTION
		, ADD INDEX `fk_city_idx` (`ref_city_id` ASC) 
		, ADD INDEX `fk_region_idx` (`ref_region_id` ASC) ;
		SQL
  end

  def down
  	execute <<-SQL
	  	ALTER TABLE `dg_development`.`ref_city_region` 
	  	DROP FOREIGN KEY `fk_region` , DROP FOREIGN KEY `fk_city` ;
	  	SQL

	 execute <<-SQL 
	 	ALTER TABLE `dg_development`.`ref_city_region` 
		DROP INDEX `fk_region_idx` 
		, DROP INDEX `fk_city_idx` ;
		SQL
  end
end
