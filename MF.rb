require 'gsl'
require 'matrix'
require 'numo/narray'

def brain_factorization(data, K, step=5000, alpha=0.002, lambada=0.02)
    W = Numo::DFloat.new((data.count,K).rand
    H = Numo::DFloat.new((data.first.count,K).rand

    H = H.to_a.tranpose

    step.times do |i|
        data.count.times do |j|
            data.first.count.times do |k|
                if data[j][k] >0
                    eij = data[k][k] - W[j][-1].inner_product(H[-1][k])
                    W[j][-1] += alpha*(2*eij*H[-1][k] - lambada * W[j][-1])
                    H[-1][k] += alpha*(2*eij*W[j][-1] - lambada * H[-1][k])
                end
                    edata = W.inner_product(H)
                    e = 0
                    data.count.times do |i|
                        data.first.count.times do |j|
                            if data[i][j] > 0
                                e = e + (data[i][j] - W[i][-1].inner_product(H[-1][j]) ** 2
                                K.times do |k|
                                    e = e + (lambada/2) * ( (W[i][k]**2) + (H[k][j]**2) )
                                end
                            end
                        end
                    end
                if e < 0.001:
                        break
                return W, H.to_a
    
                    end
                end
            end
        end
    end
counter = 1
begin
    file = File.new("/home/ledsinh/gg.txt", "r")
    while (line = file.gets)
        puts "#{counter}: #{line}"
        counter = counter + 1
    end
    file.close
rescue => err
    puts "Exception: #{err}"
    err
end
K = 4

W,H = brain_factorization(data, K)
facto = W.inner_product(H.T)
puts "Matrix Factorization"
for i in W:
    puts i
    puts " "
end
for i in H:
    puts i
    puts " "
    for i in facto:
        puts i.round(3)
    end
end
                
