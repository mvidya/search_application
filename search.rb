class Search

 def sample_data
  @page1= { "ford"=>8, "car"=>7, "review"=>6 }
  @page2= { "review"=>8, "car"=>7 }
  @page3= { "review"=>8, "ford"=>7 }
  @page4= { "toyota"=>8, "car"=>7 }
  @page5= { "honda"=>8, "car"=>7 }
  @page6= { "car"=>8 }
end

def test
  puts "Please enter max number of keyword allowed for a web page and query"
  n = gets.to_i
  if n==0
    "Please enter valid number"
  else
    puts "Please enter the query"
    query = gets  
    query = query.split(" ")
    query.delete("Q")

    unless query.size > n
      sample_data

      p1,p2,p3,p4,p5,p6 = 0,0,0,0,0,0

      query.each do |q|
        p1 = p1 + (n*@page1[q.downcase].to_i)
        p2 = p2 + (n*@page2[q.downcase].to_i)
        p3 = p3 + (n*@page3[q.downcase].to_i)
        p4 = p4 + (n*@page4[q.downcase].to_i)
        p5 = p5 + (n*@page5[q.downcase].to_i)
        p6 = p6 + (n*@page6[q.downcase].to_i)
        n-=1
      end
      h = Hash[{:P1=>p1, :P2=>p2, :P3=>p3, :P4=>p4, :P5=>p5, :P6=>p6}.delete_if{|k,v| v==0}]
      new_hash = {}
      while true
        break if h.empty?
        max = h.values.max
        temp_hash = Hash[h.select { |k, v| v == max}]
        new_hash = new_hash.merge(temp_hash)
        h.delete_if{|k,v| v==max}
      end
      return new_hash.keys.first(5)
    else
      "Maximun number of keywords allowed for the query is #{n}"
    end
  end
end

end

search = Search.new
puts search.test
