# Parent project does not export its library target, so this CML implicitly
# depends on being added from it, i.e. the testing is done only from the build
# tree and is not feasible from an install location

project(singTests LANGUAGES CXX)

add_executable(sing_test source/sing_test.cpp)
target_link_libraries(sing_test PRIVATE sing_lib)
target_compile_features(sing_test PRIVATE cxx_std_20)

add_test(NAME sing_test COMMAND sing_test)
