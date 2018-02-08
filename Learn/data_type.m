stu.name = 'Sam';
stu.grade = 6;
stu.subjects = {'Chinese', 'English', 'Math'};
stu.results = {99, 99, 99};

persons = repmat(struct('name', 'aaa', 'age', 17, 'weight', 40), 2, 3);

cellName = cell(2, 3);
cells = {3, [4 7; 6 6; 80 6], 'string'; sin(pi/8), 3>10, 'code'};
cells{1,2}; % »ñÈ¡ÄÚÈÝ