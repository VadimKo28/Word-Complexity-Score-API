class ComplexityCalculatorService < ApplicationService
  include Dry::Monads[:result]

  def initialize(definition)
    @definition = definition
  end

  def call
    if @definition.success?
      calculate
    else 
      @definition.failure["message"]
    end  
  end

  private 

  def calculate
    definitions, antonyms, synonyms = 0, 0, 0 

    @definition.value!.first["meanings"].each do |element|
      next if element["partOfSpeech"] == "noun"                

      definitions += element["definitions"].count 

      antonyms += element["antonyms"].count

      synonyms += element["synonyms"].count
    end

    result = (synonyms + antonyms) / definitions.to_f

    result.round(2)
  end
end