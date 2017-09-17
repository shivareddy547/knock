class Products 
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String



end
