module LabelModule
  def save_label
    label_data = []
    @labels.each do |label|
      label_data << { label_name: label.title, color_name: label.color }
    end
    File.write('./lib/jsonfiles/labels.json', JSON.pretty_generate(label_data))
  end

  def load_label
    labelfile = './lib/jsonfiles/labels.json'.freeze
    if File.exist?(labelfile) && !File.empty?(labelfile)
      JSON.parse(File.read(labelfile)).map do |lab|
        Label.new(lab['title'], lab['color'])
      end
    else
      []
    end
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels found'
    else
      puts 'List of labels'
    end
    @labels.each_with_index do |_labinfo, i|
      print "\n #{i + 1}) Label: ", label_info.title, ', '
      print '-- Color: ', labelinfo.color
      puts ' '
    end
  end
end
