require 'ahprocess'
require 'gsl'
require 'numo/narray'
require 'matrix'
decision_matricies = [[[1, 1.0/5],
                      [5,     1]],
                     [[1,     7],
                      [1.0/7, 1]],
                     [[1,     5],
                      [1.0/5, 1]]]

criteria_matrix =   [[    1, 7, 1.0/3],
                      [1.0/7, 1, 1.0/5],
                      [    3, 5,     1]]

def cross_compare(units)
    n = units.length
    A = Numo::DFloat.new(0)
    n.times do |i|
        (n-i).times do |j|
            if i == j
                scale = 1
            else
                scale = Rational(units[i]+units[j])).to_f
            A[i][j] = scale
            A[j][i] = (1/scale).to_f
            end
        end
    end
return A
end
def get_weight(A, getfrom)

    n = A.first.count
    B = Numo::DFloat.new(A)
    puts "The matrix:"
    puts A
    B.first.count.times do |i|
        sumCols = Numo::DFloat.new(B[i])
    end 
    B.count.times do |i|
        B[i].count.times do |j|
            B[i][j] /= sumCols[j]
        end
    end
    puts "Normalized matrix:"
    puts B
    B.count.times do |i|
    priority = Numo::DFloat.new((B[i][-1]/B[i].count).inner_product())
    end
    puts "Priority(Row avg):"
    puts priority
    weightedSum = A.inner_product(priority.tranpose)
    puts "Weighted sum:"
    puts weightedSum
    for weightedSum.length.times do |i|
    lamb = (([weightedSum[i]/priority[i]).sum)/n
    end
    if (getfrom == 1):
        return priority
    end
    #print(
end  
def Consistency_check
    # Consistency Checking
    RI = {1: 0, 2: 0, 3: 0.58, 4: 0.9, 5: 1.12, 6: 1.24, 7: 1.32, 8: 1.41, 9: 1.45, 10: 1.49, 11: 1.51}
    CI = (lamb - n) / (n - 1)
    CR = CI / RI[n]
    puts ('CR = %f'%CR)
    if CR >= 0.1:
        print("Failed in Consistency check.")
        exit = input("Enter 'q' to quit.")
        raise
    return priority, CR
    end
end

    no_decisions = 2
    a = AHProcess.decide(decision_matricies, criteria_matrix, no_decisions)
    b =AHProcess.consistency_ratios(decision_matricies, AHProcess::RandomConsistencyIndexTable.index(no_decisions), criteria_matrix)
    a.each {|r| puts r.inspect}
    b.each {|r| puts r.inspect}