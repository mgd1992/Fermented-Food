if Rails.env.test? && ENV["CI"]
  module ActiveRecord
    module ConnectionAdapters
      module PostgreSQL
        module SchemaStatements
          def enable_extension(name, **)
            super
          rescue ActiveRecord::StatementInvalid => e
            raise unless e.message.include?("not available") || e.message.include?("control file")
            Rails.logger.warn "Skipping unavailable extension: #{name}"
          end

          def create_schema(schema_name, **)
            super
          rescue ActiveRecord::StatementInvalid => e
            raise unless e.message.include?("already exists") || e.message.include?("pg_catalog")
            Rails.logger.warn "Skipping schema: #{schema_name}"
          end
        end
      end
    end
  end
end
