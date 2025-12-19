<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>피타고라스 정리 계산기</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@600;800;900&display=swap');
        
        body {
            font-family: 'Pretendard', sans-serif;
            background-color: #ffffff;
            color: #000000;
            margin: 0;
            overflow-x: hidden;
            line-height: 1.6;
        }

        .border-black-heavy {
            border: 3px solid #000000;
        }

        .bg-gray-soft {
            background-color: #f8f9fa;
        }

        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .triangle-path {
            transition: all 0.5s ease-in-out;
        }

        input:disabled {
            background-color: #f1f3f5;
            color: #adb5bd;
            cursor: not-allowed;
            border-color: #dee2e6;
        }

        h1, h2, h3, label, b, strong, button {
            font-weight: 800 !important;
        }
        
        p, input, text {
            font-weight: 600;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col items-center py-16 px-6">

    <!-- 헤더 -->
    <header class="text-center mb-16">
        <h1 class="text-5xl font-black mb-6 tracking-tight">피타고라스 정리 계산기</h1>
        <p class="text-gray-700 max-w-2xl mx-auto text-lg font-bold">
            직각삼각형의 변 길이를 계산하는 도구다.<br>3000년 전 수학의 비밀도 함께 확인할 수 있다.
        </p>
    </header>

    <main class="max-w-6xl w-full grid lg:grid-cols-2 gap-10 items-stretch mb-10">
        <!-- 왼쪽: 미리보기 -->
        <div class="flex flex-col gap-6">
            <div class="border-black-heavy rounded-[2rem] p-10 flex flex-col justify-between shadow-sm h-full">
                <div>
                    <div class="flex items-center gap-3 mb-10">
                        <h2 class="text-2xl">도형 모양 확인</h2>
                    </div>

                    <div class="relative h-72 flex items-center justify-center bg-gray-50 rounded-3xl border-2 border-dashed border-gray-300">
                        <svg width="280" height="240" viewBox="0 0 260 220" id="triangleSvg">
                            <polygon id="trianglePoly" points="40,130 40,180 140,180" fill="none" stroke="#000000" stroke-width="5" class="triangle-path" />
                            
                            <text id="labelA" x="25" y="155" class="fill-gray-600 text-[14px]" text-anchor="end">높이(a)</text>
                            <text id="labelB" x="90" y="200" class="fill-gray-600 text-[14px]" text-anchor="middle">밑변(b)</text>
                            <text id="labelC" x="100" y="150" class="fill-black text-[16px] font-bold" text-anchor="start">빗변(c)</text>
                        </svg>
                    </div>
                </div>
                <div class="mt-10 p-8 bg-black rounded-2xl text-white">
                    <div class="text-gray-400 mb-2 text-xs uppercase tracking-widest font-bold">수학 공식</div>
                    <p class="text-4xl font-black italic">a² + b² = c²</p>
                </div>
            </div>
        </div>

        <!-- 오른쪽: 입력 및 결과 -->
        <div class="border-black-heavy rounded-[2rem] p-10 flex flex-col gap-8 shadow-sm bg-white">
            <div class="space-y-8">
                <div class="flex items-center justify-between">
                    <h2 class="text-2xl">숫자 입력</h2>
                    <button id="resetBtn" class="text-gray-500 hover:text-black transition-colors text-base underline decoration-4 underline-offset-8">
                        다시 하기
                    </button>
                </div>
                <div class="space-y-6">
                    <div id="groupA">
                        <label class="block text-base mb-3 ml-1 text-gray-900">높이 (변 a)</label>
                        <input type="number" id="inputA" placeholder="숫자를 입력한다" class="w-full bg-white border-2 border-black rounded-2xl px-6 py-5 outline-none focus:ring-8 focus:ring-gray-100 transition-all text-xl font-bold">
                    </div>
                    <div id="groupB">
                        <label class="block text-base mb-3 ml-1 text-gray-900">밑변 (변 b)</label>
                        <input type="number" id="inputB" placeholder="숫자를 입력한다" class="w-full bg-white border-2 border-black rounded-2xl px-6 py-5 outline-none focus:ring-8 focus:ring-gray-100 transition-all text-xl font-bold">
                    </div>
                    <div id="groupC">
                        <label class="block text-base mb-3 ml-1 text-gray-900">빗변 (변 c)</label>
                        <input type="number" id="inputC" placeholder="숫자를 입력한다" class="w-full bg-white border-2 border-black rounded-2xl px-6 py-5 outline-none focus:ring-8 focus:ring-gray-100 transition-all text-xl font-bold">
                    </div>
                </div>
            </div>

            <div id="resultContainer" class="flex-1 flex flex-col justify-end min-h-[160px]">
                <div class="p-8 border-2 border-dashed border-gray-300 rounded-[1.5rem] flex flex-col items-center justify-center text-gray-500 gap-3 bg-gray-50">
                    <p class="text-base text-center leading-relaxed font-bold">삼각형의 변 중 2개만 숫자를 넣으면<br>나머지 하나를 바로 계산해 드립니다.</p>
                </div>
            </div>
        </div>
    </main>

    <!-- 역사 섹션 -->
    <section class="max-w-6xl w-full grid md:grid-cols-2 gap-10 mb-16">
        <div class="border-black-heavy p-12 rounded-[2rem] bg-gray-50">
            <h3 class="text-2xl mb-8">공식 원리 설명</h3>
            <div class="space-y-6 text-gray-800 text-lg leading-relaxed font-bold">
                <p>직각삼각형의 가장 긴 변을 제곱하면, 나머지 두 짧은 변을 각각 제곱해서 더한 값과 정확히 일치한다는 것이 이 공식의 핵심입니다.</p>
                <p>예를 들어 높이가 3이고 밑변이 4인 삼각형이 있다면, 3의 제곱(9)과 4의 제곱(16)을 더한 값인 25가 빗변의 제곱이 됩니다. 따라서 빗변의 길이는 5라는 사실을 알 수 있습니다.</p>
            </div>
        </div>

        <div class="border-black-heavy p-12 rounded-[2rem]">
            <h3 class="text-2xl mb-8">아무도 몰랐던 무서운 비밀</h3>
            <div class="space-y-6 text-gray-800 text-lg leading-relaxed font-bold">
                <p>삼각형을 계산하다 보니, 일반적인 숫자로 딱 떨어지지 않는 <strong>무리수(√2)</strong>라는 존재가 드러났다. "모든 건 깔끔한 숫자로 설명된다"고 믿었던 학파 사람들에게는 엄청난 충격이었다.</p>
                <p>전해지는 이야기에 따르면, 이 비밀을 외부에 알렸던 제자 히파소스는 모임에서 쫓겨나 큰 벌을 받았다. 이 공식은 단순한 수학을 넘어 세상을 보는 눈을 바꿔놓았다.</p>
            </div>
        </div>
    </section>

    <!-- 실생활 활용 -->
    <section class="max-w-6xl w-full bg-black text-white p-12 rounded-[2.5rem] mb-16">
        <h3 class="text-2xl mb-10 text-center uppercase tracking-widest">우리 생활 어디에 쓰일까?</h3>
        <div class="grid md:grid-cols-3 gap-12 text-lg">
            <div class="space-y-4">
                <div class="text-xl border-b border-gray-700 pb-2 font-black uppercase">집 짓기</div>
                <p class="text-gray-400 leading-relaxed font-bold">건물을 똑바로 세우거나 지붕의 길이를 잴 때 사용한다.</p>
            </div>
            <div class="space-y-4">
                <div class="text-xl border-b border-gray-700 pb-2 font-black uppercase">지도와 길 찾기</div>
                <p class="text-gray-400 leading-relaxed font-bold">스마트폰 지도로 현재 위치에서 목적지까지의 거리를 잴 때 쓰인다.</p>
            </div>
            <div class="space-y-4">
                <div class="text-xl border-b border-gray-700 pb-2 font-black uppercase">화면 크기</div>
                <p class="text-gray-400 leading-relaxed font-bold">TV나 휴대폰 화면의 대각선 길이를 잴 때도 활용한다.</p>
            </div>
        </div>
    </section>

    <footer class="mt-8 mb-16 text-gray-400 text-sm tracking-widest uppercase font-black">
        수학 공부용 자료 - 2025
    </footer>

    <script>
        const inputA = document.getElementById('inputA');
        const inputB = document.getElementById('inputB');
        const inputC = document.getElementById('inputC');
        const resetBtn = document.getElementById('resetBtn');
        const resultContainer = document.getElementById('resultContainer');
        const trianglePoly = document.getElementById('trianglePoly');
        
        const labels = {
            a: document.getElementById('labelA'),
            b: document.getElementById('labelB'),
            c: document.getElementById('labelC')
        };

        function calculate() {
            const a = parseFloat(inputA.value);
            const b = parseFloat(inputB.value);
            const c = parseFloat(inputC.value);

            const filled = [];
            if (inputA.value !== '' && !isNaN(a)) filled.push('a');
            if (inputB.value !== '' && !isNaN(b)) filled.push('b');
            if (inputC.value !== '' && !isNaN(c)) filled.push('c');

            [inputA, inputB, inputC].forEach(input => {
                const id = input.id.replace('input', '').toLowerCase();
                if (filled.length >= 2 && !filled.includes(id)) {
                    input.disabled = true;
                    input.placeholder = "결과 출력 중";
                } else {
                    input.disabled = false;
                    input.placeholder = "숫자를 입력한다";
                }
            });

            if (filled.length === 2) {
                let result = null;
                let type = '';
                let formula = '';
                let error = '';

                try {
                    if (filled.includes('a') && filled.includes('b')) {
                        result = Math.sqrt(a**2 + b**2);
                        type = 'c';
                        formula = `√(a² + b²)`;
                    } else if (filled.includes('a') && filled.includes('c')) {
                        if (c <= a) error = "빗변(c)은 높이(a)보다 길어야 합니다.";
                        else {
                            result = Math.sqrt(c**2 - a**2);
                            type = 'b';
                            formula = `√(c² - a²)`;
                        }
                    } else if (filled.includes('b') && filled.includes('c')) {
                        if (c <= b) error = "빗변(c)은 밑변(b)보다 길어야 합니다.";
                        else {
                            result = Math.sqrt(c**2 - b**2);
                            type = 'a';
                            formula = `√(c² - b²)`;
                        }
                    }
                } catch (e) {
                    error = "계산 과정에서 문제가 생겼습니다.";
                }

                if (error) {
                    showError(error);
                } else {
                    showResult(type, result, formula);
                    updateTriangle(type, result);
                }
            } else {
                showPlaceholder();
                updateTriangle(null, null);
            }
        }

        function showResult(type, value, formula) {
            const name = type === 'a' ? '높이(a)' : type === 'b' ? '밑변(b)' : '빗변(c)';
            resultContainer.innerHTML = `
                <div class="bg-black p-8 rounded-[1.5rem] shadow-2xl animate-in zoom-in duration-300">
                    <div class="flex justify-between items-start mb-3">
                       <span class="text-gray-400 text-sm font-bold tracking-widest uppercase">${name}의 길이</span>
                    </div>
                    <div class="text-5xl font-black text-white">
                      ${value.toLocaleString(undefined, { maximumFractionDigits: 4 })}
                    </div>
                    <div class="mt-4 text-sm text-gray-500 font-bold">적용 공식: ${formula}</div>
                </div>
            `;
        }

        function showError(msg) {
            resultContainer.innerHTML = `
                <div class="border-4 border-black p-6 rounded-2xl flex items-center justify-center bg-gray-50">
                    <p class="text-lg font-black text-black underline decoration-red-500 decoration-4">${msg}</p>
                </div>
            `;
        }

        function showPlaceholder() {
            resultContainer.innerHTML = `
                <div class="p-8 border-2 border-dashed border-gray-300 rounded-[1.5rem] flex flex-col items-center justify-center text-gray-500 gap-3 bg-gray-50">
                    <p class="text-base text-center leading-relaxed font-bold">삼각형의 변 중 2개만 숫자를 넣으면<br>나머지 하나를 바로 계산해 드립니다.</p>
                </div>
            `;
        }

        function updateTriangle(resultType, resultValue) {
            const maxWidth = 200;
            const maxHeight = 160;
            const x0 = 40;
            const y0 = 180;

            let a = parseFloat(inputA.value) || (resultType === 'a' ? resultValue : 50);
            let b = parseFloat(inputB.value) || (resultType === 'b' ? resultValue : 100);

            if (isNaN(a) || a <= 0) a = 50;
            if (isNaN(b) || b <= 0) b = 100;

            const scale = Math.min(maxWidth / b, maxHeight / a);
            const w = b * scale;
            const h = a * scale;

            trianglePoly.setAttribute('points', `${x0},${y0-h} ${x0},${y0} ${x0+w},${y0}`);
            
            labels.a.setAttribute('y', y0 - h/2);
            labels.b.setAttribute('x', x0 + w/2);
            labels.c.setAttribute('x', x0 + w/2 + 10);
            labels.c.setAttribute('y', y0 - h/2 - 10);
        }

        [inputA, inputB, inputC].forEach(input => {
            input.addEventListener('input', calculate);
        });

        resetBtn.addEventListener('click', () => {
            inputA.value = '';
            inputB.value = '';
            inputC.value = '';
            calculate();
        });

        calculate();
    </script>
</body>
</html>
