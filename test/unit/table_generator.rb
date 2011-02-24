require "test/test_helper"

class TableGeneratorTest < ActiveSupport::TestCase
  TEMP_DIRECTORY = File.expand_path "#{RAILS_ROOT}/tmp"
  def setup
    @emef_data = get_hash(11)
    @emei_data = get_hash(10)
    @creche_data = get_hash(10)
    @institutions = []
    (1..60).each{|i| @institutions << ["teste_#{i}",i]}
    @eleven_dimensions = (1..11).collect
    @ten_dimensions = (1..10).collect
    puts @institutions.inspect
    puts @eleven_dimensions.inspect
    puts @emef_data.inspect
  end

  def get_hash(last_dimension)
    hash = {}
    (1..last_dimension).each do |dimension|
      (1..60).each do |institution|
        institution = "teste_#{institution}"
        hash[institution] = {} if hash[institution].nil?
        hash[institution][dimension] = [0.3, 0.5, 0.7].shuffle.first
      end
    end
    hash
  end

  test "gerar tabela do EMEF" do
    UniFreire::Tables::Generator.build_html(@emef_data, @institutions, @eleven_dimensions)
    table_file = File.new(File.join(TEMP_DIRECTORY,'tabela.html'))
    UniFreire::Tables::Generator.send(:convert_html_to_pdf,table_file, "tabela_TESTE")
  end

  test "gerar tabela do EMEI" do
  end

  test "gerar tabela do Creche" do
  end

end

