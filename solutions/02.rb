class TodoList
  attr_accessor :collection

  include Enumerable

  def initialize
    @collection = []
  end

  def self.parse(text)
    rows = text.split("\n")
    created_todo_list = TodoList.new
    fill_collection_with_tasks(created_todo_list, rows)
    created_todo_list
  end

  def self.fill_collection_with_tasks(created_todo_list, rows)
    rows.each do |row|
    splited = row.split("|")
    task = Task.new(splited[0], splited[1], splited[2], splited[3])
    created_todo_list.collection << task
    end
  end

  def each
    collection.each { |task| yield task }
  end

  def filter(criteria)
    filtered = TodoList.new
    filtered.collection = @collection.select { |task| criteria.meets?(task) }
    filtered
  end

  def adjoin(other_list)
    joined_collection = @collection.concat other_list.collection
    joined_todo_list = TodoList.new
    joined_todo_list.collection = joined_collection
    joined_todo_list
  end

  def tasks_todo
    @collection.select { |task| task.status == :todo }.count
  end

  def tasks_in_progress
    @collection.select { |task| task.status == :current }.count
  end

  def tasks_completed
    @collection.select { |task| task.status == :done }.count
  end

  def completed?
    @collection.all? { |task| task.status == :completed }.count
  end
end

class Task
  attr_accessor :status, :description, :priority, :tags

  def initialize(status, description, priority, tags = nil)
    @status = status.strip.downcase.to_sym
    @description = description.strip
    @priority = priority.strip.downcase.to_sym
    @tags = tags.nil? ? [] : tags.split(", ").map(&:strip)
  end

  def status
    @status
  end

  def description
    @description
  end

  def priority
    @priority
  end

  def tags
    @tags
  end
end

class Criteria
  attr_accessor :filter

  def initialize(filter)
    @filter = filter
  end

  def meets?(task)
    @filter.call(task)
  end

  def self.status(status)
    Criteria.new ->(task) { task.status == status }
  end

  def self.priority(priority)
    Criteria.new ->(task) { task.priority == priority }
  end

  def self.tags(tags)
    Criteria.new ->(task) { (task.tags + tags).sort.uniq == task.tags.sort.uniq}
  end

  def &(other_criteria)
    Criteria.new ->(task) { meets?(task) and other_criteria.meets?(task) }
  end

  def |(other_criteria)
    Criteria.new ->(task) { meets?(task) or other_criteria.meets?(task) }
  end

  def !
    Criteria.new ->(task) { not meets?(task) }
  end
end