require 'gsl'
require 'numo/narray'
require 'matrix'
$input = [[1, 4, 5, 0, 3], 
          [5, 1, 0, 5, 2], 
          [4, 1, 2, 5, 0], 
          [0, 3, 4, 0, 4]]
$alt_input = $input.transpose
Matrix.diagonal(1,1,1,1).to_a.each_slice(5).to_a
$diagCosin =  [[1,0,0,0],
              [0,1,0,0],
              [0,0,1,0],
              [0,0,0,1]]
$diagPearson =[[1,0,0,0],
              [0,1,0,0],
              [0,0,1,0],
              [0,0,0,1]]
def cosin(a, b)
  #Tinh tong binh phuong cac gia tri
  sumaSq=a.inject(0) {|r,i| r + i**2}
  sumbSq=b.inject(0) {|r,i| r + i**2}
  #Tinh tong a[i]*b[i]
  prods=[]; a.each_with_index{|this_a,i| prods << this_a*b[i]}
  pSum=prods.inject(0){|r,i| r + i}

  abMau = Math.sqrt(sumaSq) * Math.sqrt(sumbSq)
  if abMau == 0
    return 0
    else return pSum / abMau
  end
end
def pearson(x,y)
  n = x.length
  #Tinh tong cac phan tu
  sumx=x.inject(0) {|r,i| r + i}
  sumy=y.inject(0) {|r,i| r + i}
  #Tinh tong binh phuong cac phan tu
  sumxSq=x.inject(0) {|r,i| r + i**2}
  sumySq=y.inject(0) {|r,i| r + i**2}
  #Tinh tong a[i]*b[i]
  prods=[]; x.each_with_index{|this_x,i| prods << this_x*y[i]}
  pSum=prods.inject(0){|r,i| r + i}

  num=pSum-(sumx*sumy/n)
  den=((sumxSq-(sumx**2)/n)*((sumySq-(sumy**2)/n)))**0.5
  if den==0
    return 0
  end
  r=num/den
  return r
end
#Tinh trung binh trong mang
def Avg(user)
  sodanhgia = 0
  ru = 0
  $input.first.count.times do |i|
    if $input[user][i] != 0
      sodanhgia+= 1
      ru += $input[user][i]
    end
  end
    ru /= sodanhgia
    return ru
end
def dudoan_lech(user, item, checksum)
  userTemp =0
  t1,t2=0,0
  rU = Array.new(2)
  ru, langgieng, tu, mau = 0,0,0,0
  k = 2
  ku = Array.new(3)
  ku_index = Array.new(3)
  row, col = 4, 4
  @table = Array.new(row){Array.new(col,1)}
  if checksum == 1
    for i in $input
      for j in $input
        @table[t1][t2] = pearson(i,j).round(3)
        t2+=1
      end
        t2=0
        t1+=1
    end
    4.times do |i|
      if i != user 
        ku[langgieng] = @table[i][user]
        ku_index[langgieng] = i
        langgieng+=1
      end
    end
  else
    for i in $input
      for j in $input
        @table[t1][t2] = cosin(i,j).round(3)
        t2+=1
      end
        t2=0
        t1+=1
    end
    4.times do |i|
      if i != user 
        ku[langgieng] = @table[i][user]
        ku_index[langgieng] = i
        langgieng+=1
      end
    end
  end
  ru = Avg(user)
  k.times do |i|
    userTemp = ku_index[i]
    rU[i] = Avg(userTemp)
  end
  k.times do |j|
    userTemp = ku_index[j]
    tu += ku[j] * ($input[userTemp][item] - rU[j])
    mau += ku[j]
  end
  return (ru +  (tu / mau)).round(3)
end
def dudoan_tong(user, item, checksum)
  k = 2
  ku = Array.new(3)
  ku_index = Array.new(3)
  langgieng = 0
  row, col = 5, 4
  @table = Array.new(row){Array.new(col)}
  t1, t2 = 0, 0 
  if checksum == 1
    for i in $alt_input
      for j in $alt_input
        @table[t1][t2]  = pearson(i,j).round(3)
        t2+=1
      end
        t2=0
        t1+=1
    end
  else
    for i in $alt_input
      for j in $alt_input
        @table[t1][t2]  = cosin(i,j).round(3)
        t2+=1
      end
        t2=0
        t1+=1
    end 
  end
  4.times do |i|
    if i != user 
      ku[langgieng] = @table[i][user]
      ku_index[langgieng] = i
      langgieng+=1
    end
  end
  tu, mau =0,0
  k.times do |j|
    tu += ku[j] * $alt_input[ku_index[j]][item]
    mau += ku[j]
  end
  return (tu/mau).round(3)
end
def goiYU_U (output, checksum)
  $input.count.times do |i|
    $input.first.count.times do |j|
      if $input[i][j] == 0
        output[i][j] = dudoan_lech(i,j,checksum)
      else output[i][j] = $input[i][j]
      end
    end
  end
end
def goiYI_I (output, checksum)
  $alt_input.count.times do |i|
    $alt_input.first.count.times do |j|
      if $alt_input[i][j] == 0
        output[i][j] = dudoan_tong(i,j,checksum)
      else output[i][j] = $alt_input[i][j]
      end
    end
  end
end

#################################
t1,t2=0,0
t3,t4=0,0
rowU, colU = 4, 5
rowI, colI = 5, 4
tableU = Array.new(rowU){Array.new(colU)}
tableI = Array.new(rowI){Array.new(colI)}
goiYU_U(tableU, 2)
goiYI_I(tableI,2)
for i in $input
  for j in $input
    $diagPearson[t1][t2] = pearson(i,j).round(3)
    t2+=1
  end
    t2=0
    t1+=1
end
for i in $input
  for j in $input
    $diagCosin[t3][t4] = cosin(i,j).round(3)
    t4+=1
  end
    t4=0
    t3+=1
end

puts "Do lech Pearson"
$diagPearson.each {|r| puts r.inspect}
puts "Do lech Cosine"
$diagCosin.each {|r| puts r.inspect}

puts "Ket qua goi y theo U-U dung du doan lech "
tableU.each {|r| puts r.inspect}
puts "Ket qua goy theo I-I dung du doan tong"
tableI_tran = tableI.transpose
tableI_tran.each {|r| puts r.inspect}
puts ''


