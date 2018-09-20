require 'gsl'
require 'numo/narray'
require 'matrix'
  def cosin(a, b)
    if a.is_a?(Array) && b.is_a?(Array)
      if a.length != b.length
        puts '2 ma tran khong bang nhau'
        return -1
      end

      dataLength = a.length
      ab = 0
      coA = 0
      coB = 0

      dataLength.times do |i|
        ab += a[i] * b[i]
      end

      for i in a do
        coA += i**2
      end
      for i in b do
        coB += i**2
      end

      cosinA = Math.sqrt(coA)
      cosinB = Math.sqrt(coB)
      abMau = cosinA * cosinB

      if abMau == 0
        return 0
      else return ab / abMau
      end
    else
      print 'Dau vao sai'
      -1
    end
  end

  def pearson(x,y)
    n=x.length
  
    sumx=x.inject(0) {|r,i| r + i}
    sumy=y.inject(0) {|r,i| r + i}
  
    sumxSq=x.inject(0) {|r,i| r + i**2}
    sumySq=y.inject(0) {|r,i| r + i**2}
  
    prods=[]; x.each_with_index{|this_x,i| prods << this_x*y[i]}
    pSum=prods.inject(0){|r,i| r + i}
  
    # Calculate Pearson score
    num=pSum-(sumx*sumy/n)
    den=((sumxSq-(sumx**2)/n)*(sumySq-(sumy**2)/n))**0.5
    if den==0
      return 0
    end
    r=num/den
    return r
  end
  
=begin
  def pearson(a, b)
    if a.is_a?(Array) && b.is_a?(Array)
      if a.length != b.length
        puts '2 ma tran khong bang nhau'
        return -1
      end

      dataLength = a.length
      intersection = []

      dataLength.times do |i|
        intersection[i] = i if a[i] != 0 && b[i] != 0
      end

      return 0 if intersection.empty?

      arrayAvgA = []
      for i in a
        arrayAvgA[i] = i if i != 0
      end
      avgA = arrayAvgA.compact.reduce(0, :+).to_f / arrayAvgA.compact.size
      arrayAvgB = []
      for i in b
        arrayAvgB[i] = i if i != 0
      end
      avgB = arrayAvgB.compact.reduce(0, :+).to_f / arrayAvgB.compact.size

      numerator = 0
      for i in intersection
        numerator += (a[i] - avgA) * (b[i] - avgB)
      end

      deviaAsum = 0
      for i in intersection
        deviaAsum += (a[i] - avgA)**2
      end
      deviationA = Math.sqrt(deviaAsum)
      deviaBsum = 0
      for i in intersection
        deviaBsum += (b[i] - avgB)**2
      end
      deviationB = Math.sqrt(deviaBsum)

      return 0 if (deviationA * deviationB) == 0
      numerator / (deviationA * deviationB)
    end
  end
=end
=begin
  def KNN(data, measure, k)
    exData = measure(i,j)
    newData = Numo::DFloat[]
    data.length.times do |i|
      newData.append([])
      data[i].length.times do |j|
        if data[i][j] == 0
          exData.length.times do |k|
            userCollumn = Numo::DFLoat[exData[i][k], k]
          end
          userCollumn.sort()
          taken = userCol.slice(0..k)

          predictAvg = []
          for l in data[i]
            if l != 0
              predictAvg[l] = l 
            end
          end
          predict = predictAvg.compact.reduce(0, :+).to_f / predictAvg.compact.size
          
          userSimilarAvg = []
          userSimilarMean = []
          for m taken
            for n in data[m[1]]
              if n !=0
                userSimilar[n] = n
              end
              userSimilar = userSimilarAvg.compact.reduce(0, :+).to_f / userSimilarAvg.compact.size
            end
            userSimilarMean[m] = U
            

            numerator
            taken.length.times do |k|
              numerator += [exData[i][taken[k][1]]*(data[i][taken[k][1]] - similarUserMean[k]
            






            
          
          end
        end
      end
    end
  end
end
=end
  a = [2,3,5,7]
  b = [3,5,7,9]
  c = [3,4,7,8]
  d = [3,4,6,8]
  data = Numo::DFloat[a,b,c,d]
  table = Numo::DFloat.new(4,4)
  a.length.times do |i|
    a.length.times do |j|
      table = cosin(data[i,j], data[i,j])
    end
  end
puts table

