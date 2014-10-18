# Fix geokit-rails
# https://github.com/geokit/geokit-rails/blob/master/lib/geokit-rails/acts_as_mappable.rb#L237
Arel::SqlLiteral = Arel::Nodes::SqlLiteral
