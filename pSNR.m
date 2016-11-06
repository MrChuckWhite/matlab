function answer = pSNR(x, y)

    answer = 0;
    len = length(x);
    for i = 1:len
        for j = 1:len
            answer = answer + (x(i,j) - y(i,j))^2;
        end
    end
    
    answer = 10*log(255^2 / answer);

end