class MultipleChoicesView < UIView
  attr_accessor :data

  def data=(d)
    @data = d
    @selected_choices = Array.new(d.count) { false }
    self.tag = 300
    initUIComponents
  end

  def initUIComponents
    @table = UITableView.alloc.initWithFrame(self.bounds)
    self.addSubview @table
    @table.dataSource = self
    @table.delegate = self
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'MULTIPLE_CHOICES_CELL'
    _cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    end
    _cell.textLabel.text = @data[indexPath.row][:content]
    _cell
  end

  def tableView(tableView, numberOfRowsInSection: indexPath)
    @data.count
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    _cell = tableView.cellForRowAtIndexPath(indexPath)
    if @selected_choices[indexPath.row]
      _cell.accessoryType = UITableViewCellAccessoryNone
      @selected_choices[indexPath.row] = false
    else
      _cell.accessoryType = UITableViewCellAccessoryCheckmark
      @selected_choices[indexPath.row] = true
    end
  end

  def answerText
    @selected_choices
  end
end


