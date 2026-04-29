copy %RECIPE_DIR%\CMakeLists.txt .
copy %RECIPE_DIR%\FindGMP.cmake .

cmake -LAH -G "Ninja" ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -B build .
if errorlevel 1 exit 1

cmake --build build --target install --config Release --parallel %CPU_COUNT%
if errorlevel 1 exit 1

ctest --test-dir build --output-on-failure -j%CPU_COUNT%
if errorlevel 1 exit 1
